//
//  JoinTableView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/18/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI
import MultipeerConnectivity

struct JoinTableView: View {
    @EnvironmentObject var tableData: TableData
    @State private var invitations: [(hostName: String, callback: (Bool, MCSession?)-> Void)] = []
    @State private var pendingInvitations: Bool = false
    @State private var joinedTable: Int? = 0
    @State private var tableHost: String = ""
    let tableService: TableService
    
    init(userName: String) {
        self.tableService = TableService(userName: userName)
    }
    
    func acceptInvitation(invitationIndex: Int) {
        self.invitations[invitationIndex].callback(true, self.tableService.session)
        self.tableHost = self.invitations[invitationIndex].hostName
        self.invitations.removeFirst()
        self.pendingInvitations = (self.invitations.isEmpty)
        self.joinedTable = 1
    }
    
    func declineInvitation(invitationIndex: Int) {
        self.invitations[invitationIndex].callback(false, nil)
        self.invitations.removeFirst()
        self.pendingInvitations = (self.invitations.isEmpty)
    }
    
    var body: some View {
        VStack {
            
            NavigationLink(
                destination: TableGuestView(hostName: self.tableHost)
                    .environmentObject(self.tableService),
                tag: 1,
                selection: self.$joinedTable) {
                    EmptyView()
            }
            
            if(invitations.isEmpty) {
                Text("Waiting for invitation from host")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("AppBlue"))
            }
            else {
                List(invitations.indices, id: \.self) { index in
                    HStack {
                        Text(self.invitations[index].hostName)
                            .foregroundColor(Color("AppBlue"))
                            .padding()
                        
                        Spacer()
                        
                        ButtonView(buttonText: "Join", buttonColor: Color("AppBlue"))
                            .onTapGesture {
                                self.acceptInvitation(invitationIndex: index)
                        }
                        
                        
                        ButtonView(buttonText: "Decline", buttonColor: Color("AppOrange"))
                            .onTapGesture { 
                                self.declineInvitation(invitationIndex: index)
                        }
                    }
                    
                }
                .accentColor(Color("AppBlue"))
            }
            
        }
        .onAppear() {
            self.tableService.delegate = self
            self.tableService.searchForTable()
        }
        .navigationBarTitle("Join Table")
    }
}

extension JoinTableView: TableServiceDelegate {
    func placesReceived(manager: TableService, places: [GooglePlace]) {
        self.tableData.receivedPlaces = places
    }
    
    func likedPlaceReceived(manager: TableService, place: GooglePlace) {
        self.tableData.addLikedPlace(place: place)
    }
    
    func guestDiscovered(manager: TableService, guestID: MCPeerID, guestName: String) {
        
    }
    
    func guestLost(manager: TableService, guestID: MCPeerID) {
        
    }
    
    func receivedInvitation(manager: TableService, hostName: String, invitationHandler: @escaping (Bool, MCSession?) -> Void){
        self.invitations.append((hostName, invitationHandler))
        self.pendingInvitations = true
    }
    
    func peerChangedState(manager: TableService, peerID: MCPeerID, state: MCSessionState) {
        if state == MCSessionState.connected {
            DispatchQueue.main.async {
                self.tableData.numberOfGuests = 1 + self.tableService.session.connectedPeers.count
            }
        }
    }
}

struct JoinTableView_Previews: PreviewProvider {
    static var previews: some View {
        JoinTableView(userName: "Test User")
    }
}
