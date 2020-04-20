//
//  SelectGuestsView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/18/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI
import MultipeerConnectivity

struct InviteGuestsView: View {
    @State private var guests: [Guest] = []
    var userName: String
    let tableService: TableService
    
    init(userName: String) {
        self.userName = userName
        self.tableService = TableService(userName: userName)
    }
    
    func displayGuestState(guest: Guest) -> AnyView {
        switch guest.state {
        case MCSessionState.connected:
            return AnyView(Text("Connected"))
        case MCSessionState.connecting:
            return AnyView(Text("Connecting"))
        default:
            return AnyView(Button(action: {
                self.tableService.inviteGuest(guestID: guest.id, hostName: self.userName)
            }) {
                Text("Invite")
                    .foregroundColor(Color.blue)
            })
        }
    }
    
    var body: some View {
        VStack {
            List(guests) { guest in
                HStack {
                    Text(guest.name)
                    
                    Spacer()
                    
                    self.displayGuestState(guest: guest)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: TableHostView(guests: self.$guests).environmentObject(tableService)) {
                ButtonView(buttonText: "Start Table", buttonColor: Color("AppBlue"))
            }
        }
        .navigationBarTitle("Invite Table Guests")
        .onAppear() {
            self.tableService.delegate = self
            self.tableService.createTable()
        }
        .onDisappear() {
            self.tableService.closeTable()
        }
    }
}

extension InviteGuestsView: TableServiceDelegate {
    func guestDiscovered(manager: TableService, guestID: MCPeerID, guestName: String) {
        self.guests.append(Guest(id: guestID, name: guestName))
    }
    
    func guestLost(manager: TableService, guestID: MCPeerID) {
        self.guests = self.guests.filter({$0.id != guestID})
    }
    
    func receivedInvitation(manager: TableService, hostName: String, invitationHandler: @escaping (Bool, MCSession?) -> Void){ }
    
    func peerChangedState(manager: TableService, peerID: MCPeerID, state: MCSessionState) {
        self.guests = self.guests.map() {
            if ($0.id == peerID) {
                return Guest(id: $0.id, name: $0.name, state: state)
            }
            else {
                return $0
            }
        }
    }
    
    func peerConnecting(manager: TableService, peerID: MCPeerID) {
        self.guests.first(where: {$0.id == peerID})?.state = MCSessionState.connecting
    }
    
    func peerDisconnected(manager: TableService, peerID: MCPeerID) {
        self.guests.first(where: {$0.id == peerID})?.state = MCSessionState.notConnected
    }
    
    func messageReceived(manager: TableService, message: String) { }
    
    
}

struct InviteGuestsView_Previews: PreviewProvider {
    static var previews: some View {
        InviteGuestsView(userName: "Test User")
    }
}
