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
    @EnvironmentObject var tableData: TableData
    
    var body: some View {
        VStack {
            Form{
                Section(
                    header: Text("Guests:")
                        .foregroundColor(Color("AppBlue"))
                        .font(.title)
                        .fontWeight(.bold)
                ) {
                    InviteGuestsView()
                }
                
            }
            Spacer()
            
            NavigationLink(destination: ChooseRestaurantsView().environmentObject(self.tableService)) {
                ButtonView(buttonText: "Choose Restaurant", buttonColor: Color("AppBlue"))
            }
            .disabled(self.tableData.receivedPlaces.isEmpty)
        }
        .navigationBarTitle("\(userData.name)'s Table")
        .onAppear() {
            if (self.tableData.receivedPlaces.isEmpty) {
                self.tableService.delegate? = self
                let dataProvider = GoogleDataProvider(tableData: self.tableData)
                dataProvider.fetchPlaces(near: self.locationManager.location!.coordinate)
            }
        }
    }
}

extension TableHostView: TableServiceDelegate {
    func likedPlaceReceived(manager: TableService, place: GooglePlace) {
        self.tableData.addLikedPlace(place: place)
    }
    
    func guestDiscovered(manager: TableService, guestID: MCPeerID, guestName: String) { }
    
    func guestLost(manager: TableService, guestID: MCPeerID) { }
    
    func receivedInvitation(manager: TableService, hostName: String, invitationHandler: @escaping (Bool, MCSession?) -> Void) { }
    
    func peerChangedState(manager: TableService, peerID: MCPeerID, state: MCSessionState) {
        
    }
    
    mutating func placesReceived(manager: TableService, places: [GooglePlace]) {
        self.tableData.receivedPlaces = places
    }
    
    
}

struct TableHostView_Previews: PreviewProvider {
    static var previews: some View {
        TableHostView()
            .environmentObject(UserData())
            .environmentObject(TableService(userName: "Test"))
            .environmentObject(TableData())
    }
}
