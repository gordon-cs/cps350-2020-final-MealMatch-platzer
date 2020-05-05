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
    @EnvironmentObject var tableData: TableData
    
    func showRestaurantCard() -> AnyView {
        if self.tableData.receivedPlaces.isEmpty {
            return AnyView(EmptyView())
        }
        else {
            return AnyView(RestaurantCardView())
        }
    }

    var body: some View {
                VStack {
                    showRestaurantCard()
                    
                    BottomBarView()
                }
        .navigationBarTitle("Choose Restaurants", displayMode: .inline)
        .onAppear() {
            self.tableService.delegate? = self
            self.tableService.sendInitialPlaces(places: self.tableData.receivedPlaces)
        }
    }
}

extension ChooseRestaurantsView: TableServiceDelegate {
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
    
    func receivedInvitation(manager: TableService, hostName: String, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    }
    
    func peerChangedState(manager: TableService, peerID: MCPeerID, state: MCSessionState) {
        if state == MCSessionState.connected {
            DispatchQueue.main.async {
                self.tableData.numberOfGuests = 1 + self.tableService.session.connectedPeers.count
            }
        }
    }
}


struct ChooseRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseRestaurantsView()
            .environmentObject(UserData())
            .environmentObject(LocationManager())
            .environmentObject(TableService(userName: "Test User"))
            .environmentObject(TableData())
    }
}
