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
    @EnvironmentObject var tableService: TableService
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Form{
                Section{
                    Text("Search Radius: \(Int(searchRadius)) km")
                    .foregroundColor(Color("AppBlue"))
                        .font(.title)
                    
                    Slider(value: $searchRadius, in: 1...50)
                    .accentColor(Color("AppBlue"))
                }
                
                Section {
                    Text("Guests:")
                    .foregroundColor(Color("AppBlue"))
                        .font(.title)
                        .fontWeight(.bold)
                    
                    InviteGuestsView()
                }
                
            }
            Spacer()
            
            NavigationLink(destination: RestaurantCardView()) {
                ButtonView(buttonText: "Choose Restaurant", buttonColor: Color("AppBlue"))
            }
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
        TableHostView()
            .environmentObject(UserData())
            .environmentObject(TableService(userName: "Test"))
    }
}
