//
//  TableGuestView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/18/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI
import MultipeerConnectivity

struct TableGuestView: View {
    @EnvironmentObject var tableService: TableService
    @EnvironmentObject var tableData: TableData
    var hostName: String
    
    var body: some View {
        VStack {
            if (self.tableData.receivedPlaces.isEmpty) {
                Text("Welcome to \(hostName)'s table!")
                    .foregroundColor(Color("AppBlue"))
            }
                
            else {
                NavigationLink(destination: ChooseRestaurantsView()
                    .environmentObject(self.tableService)) {
                        ButtonView(buttonText: "Choose Restaurants", buttonColor: Color("AppBlue"))
                }
                
            }
        }
        .navigationBarTitle("\(hostName)'s Table")
        .onAppear() {
            self.tableService.delegate = self
        }
    }
}

extension TableGuestView: TableServiceDelegate {
    func placesReceived(manager: TableService, places: [GooglePlace]) {
        print("Table Guest Delegate received places: \(places)")
        self.tableData.receivedPlaces = places
    }
    
    func likedPlaceReceived(manager: TableService, place: GooglePlace) {
        print("Table Guest Delegate received place: \(place)")
        self.tableData.addLikedPlace(place: place)
    }
    
    func guestDiscovered(manager: TableService, guestID: MCPeerID, guestName: String) {    }
    
    func guestLost(manager: TableService, guestID: MCPeerID) {}
    
    func receivedInvitation(manager: TableService, hostName: String, invitationHandler: @escaping (Bool, MCSession?) -> Void) {}
    
    func peerChangedState(manager: TableService, peerID: MCPeerID, state: MCSessionState) {
        if state == MCSessionState.connected {
            DispatchQueue.main.async {
                self.tableData.numberOfGuests = 1 + self.tableService.session.connectedPeers.count
            }
        }
    }
}

struct TableGuestView_Previews: PreviewProvider {
    static var previews: some View {
        TableGuestView(hostName: "Default Host")
            .environmentObject(TableService(userName: "Test User"))
            .environmentObject(TableData())
    }
}
