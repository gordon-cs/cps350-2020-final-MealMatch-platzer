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
    @EnvironmentObject var tableService: TableService
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var userData: UserData
    let dataProvider = GoogleDataProvider()
    @State var places: [GooglePlace] = []
    
    var body: some View {
        VStack {
            Form{
                Section {
                    Text("Guests:")
                        .foregroundColor(Color("AppBlue"))
                        .font(.title)
                        .fontWeight(.bold)

                    InviteGuestsView()
                }
                
            }
            Spacer()
            
            NavigationLink(destination: ChooseRestaurantsView(places: places).environmentObject(tableService)) {
                ButtonView(buttonText: "Choose Restaurant", buttonColor: Color("AppBlue"))
            }
            .disabled(self.places.isEmpty)
        }
        .navigationBarTitle("\(userData.name)'s Table")
        .onAppear() {
            if (self.places.isEmpty) {
                self.tableService.delegate? = self
                
                self.dataProvider.fetchPlaces(near: self.locationManager.location!.coordinate) { places in
                    print("Fetch Places call returned with places \(places)")
                    self.places = places
                }
            }
        }
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
    
    mutating func placesReceived(manager: TableService, places: [GooglePlace]) {
    }
    
    
}

struct TableHostView_Previews: PreviewProvider {
    static var previews: some View {
        TableHostView()
            .environmentObject(UserData())
            .environmentObject(TableService(userName: "Test"))
    }
}
