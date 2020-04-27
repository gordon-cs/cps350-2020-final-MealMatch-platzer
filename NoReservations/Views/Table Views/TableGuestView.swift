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
    var hostName: String
    @State var places: [GooglePlace] = []
    
    var body: some View {
        VStack {
            if (self.places.isEmpty) {
                Text("Welcome to \(hostName)'s table!")
                .foregroundColor(Color("AppBlue"))
            }
            
            else {
                ChooseRestaurantsView(places: places)
            }
        }
        .navigationBarTitle("\(hostName)'s Table")
        .onAppear() {
            self.tableService.delegate = self
        }
    }
}

extension TableGuestView: TableServiceDelegate {
    func guestDiscovered(manager: TableService, guestID: MCPeerID, guestName: String) {    }
    
    func guestLost(manager: TableService, guestID: MCPeerID) {}
    
    func receivedInvitation(manager: TableService, hostName: String, invitationHandler: @escaping (Bool, MCSession?) -> Void) {}
    
    func peerChangedState(manager: TableService, peerID: MCPeerID, state: MCSessionState) {
        
    }
    
    mutating func placesReceived(manager: TableService, places: [GooglePlace]) {
        self.places = places
    }
    
    
}

struct TableGuestView_Previews: PreviewProvider {
    static var previews: some View {
        TableGuestView(hostName: "Default Host").environmentObject(TableService(userName: "Test User"))
    }
}
