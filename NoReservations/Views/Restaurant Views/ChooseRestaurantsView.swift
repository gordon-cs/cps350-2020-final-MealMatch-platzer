//
//  ChooseRestaurantsView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/23/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import CoreLocation
import MultipeerConnectivity
import SwiftUI

struct ChooseRestaurantsView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var tableService: TableService
    @State var places: [GooglePlace]
    @State var liked: [GooglePlace] = []
        
    var body: some View {
        VStack {
            if (self.places.isEmpty) {
                Text("Loading Places")
            }
            else {
                VStack {
                    if (!self.liked.isEmpty) {
                        Text(liked.last!.name)
                    }
                    RestaurantCardView(places: self.$places)
                    
                    BottomBarView(places: self.$places, liked: self.$liked)
                }
            }
        }
        .navigationBarTitle("Choose Restaurants", displayMode: .inline)
        .onAppear() {
            self.tableService.delegate? = self
            self.tableService.sendInitialPlaces(places: self.places)
        }
    }
}

extension ChooseRestaurantsView: TableServiceDelegate {
    func guestDiscovered(manager: TableService, guestID: MCPeerID, guestName: String) {
    }
    
    func guestLost(manager: TableService, guestID: MCPeerID) {
    }
    
    func receivedInvitation(manager: TableService, hostName: String, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    }
    
    func peerChangedState(manager: TableService, peerID: MCPeerID, state: MCSessionState) {
    }
    
    func placesReceived(manager: TableService, places: [GooglePlace]) {
    }
    
    
}


struct ChooseRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseRestaurantsView(places: [])
        .environmentObject(UserData())
        .environmentObject(LocationManager())
        .environmentObject(TableService(userName: "Test User"))
    }
}
