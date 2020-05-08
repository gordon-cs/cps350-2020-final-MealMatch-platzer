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
    @State var showLikedPlaces = false
    
    func showRestaurantCard() -> AnyView {
        if self.tableData.receivedPlaces.isEmpty {
            return AnyView(EmptyView())
        }
        else {
            return AnyView(
                RestaurantCardView(
                    place: self.tableData.receivedPlaces[0],
                    likePlaceCallback: self.likePlace,
                    dislikePlaceCallback: self.dislikePlace)
            )
        }
    }
    
    func likePlace() {
        self.tableService.sendLikedPlace(place: self.tableData.receivedPlaces[0])
        self.tableData.addLikedPlace(place: self.tableData.receivedPlaces[0])
        self.tableData.receivedPlaces.removeFirst()
    }
    
    func dislikePlace() {
        self.tableData.receivedPlaces.removeFirst()
    }

    var body: some View {
                VStack {
                    showRestaurantCard()
                    
                    BottomBarView(
                        showLikedPlaces: self.$showLikedPlaces,
                        restaurantsToChoose: !self.tableData.receivedPlaces.isEmpty,
                        likePlaceCallback: self.likePlace,
                        dislikePlaceCallback: self.dislikePlace
                    )
                }
        .navigationBarTitle("Choose Restaurants", displayMode: .inline)
        .onAppear() {
            self.tableService.delegate? = self
            self.tableService.sendInitialPlaces(places: self.tableData.receivedPlaces)
        }
        .sheet(isPresented: self.$showLikedPlaces) {
            RecommendedView().environmentObject(self.tableData)
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
