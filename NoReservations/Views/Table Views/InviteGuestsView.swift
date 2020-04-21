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
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var tableService: TableService
    
    func displayGuestState(guest: Guest) -> AnyView {
        switch guest.state {
        case MCSessionState.connected:
            return AnyView(Text("Connected").foregroundColor(Color("AppBlue")))
        case MCSessionState.connecting:
            return AnyView(Text("Connecting").foregroundColor(Color("AppBlue")).fontWeight(.bold))
        default:
            return AnyView(ButtonView(buttonText: "Invite", buttonColor: Color("AppBlue")).onTapGesture {
                self.tableService.inviteGuest(guestID: guest.id, hostName: self.userData.name)
            })
        }
    }
    
    var body: some View {
        VStack {
            List(guests) { guest in
                HStack {
                    Text(guest.name)
                        .foregroundColor(Color("AppBlue"))
                        .fontWeight(.bold)
                    
                    
                    Spacer()
                    
                    self.displayGuestState(guest: guest)
                }
            }
            
            Spacer()
        }
        .onAppear() {
            self.tableService.delegate = self
            self.tableService.createTable()
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
    
    func messageReceived(manager: TableService, message: String) { }
    
    
}

struct InviteGuestsView_Previews: PreviewProvider {
    static var previews: some View {
        InviteGuestsView().environmentObject(UserData()).environmentObject(TableService(userName: "Test User"))
    }
}
