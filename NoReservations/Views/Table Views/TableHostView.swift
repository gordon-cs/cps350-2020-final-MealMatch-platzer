//
//  HostView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/16/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI
import MultipeerConnectivity

struct TableHostView: View {
    @State private var searchRadius = 1.0
    @Binding var guests: [Guest]
    @EnvironmentObject var tableService: TableService
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Form{
                Section{
                    Text("Search Radius: \(Int(searchRadius)) km")
                    Slider(value: $searchRadius, in: 1...50)
                }
                
                Section {
                    Text("Guests:")
                    List(guests) { guest in
                        Text(guest.name)
                    }
                }
                
            }
            Spacer()
            
            NavigationLink(destination: RestaurantCardView()) {
                ButtonView(buttonText: "Choose Restaurant", buttonColor: Color("AppBlue"))
            }
        }
        .onAppear() {
            self.tableService.delegate = self
        }
        .navigationBarTitle("\(userData.name)'s Table")
    }
}

extension TableHostView: TableServiceDelegate {
    func guestDiscovered(manager: TableService, guestID: MCPeerID, guestName: String) { }
    
    func guestLost(manager: TableService, guestID: MCPeerID) { }
    
    func receivedInvitation(manager: TableService, hostName: String, invitationHandler: @escaping (Bool, MCSession?) -> Void) { }
    
    func peerChangedState(manager: TableService, peerID: MCPeerID, state: MCSessionState) {
        if (state == MCSessionState.notConnected) {
            NSLog("%@", "Lost connection to peer \(peerID)")
        }
    }
    
    func messageReceived(manager: TableService, message: String) {
        
    }
    
    
}

struct TableHostView_Previews: PreviewProvider {
    static var previews: some View {
        TableHostView(guests: .constant([Guest(id: MCPeerID(displayName: "Test User"), name: "Test User")]))
            .environmentObject(UserData())
            .environmentObject(TableService(userName: "Test"))
    }
}
