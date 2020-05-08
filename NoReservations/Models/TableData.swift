//
//  RestaurantChoices.swift
//  NoReservations
//
//  Created by Evan Platzer on 5/1/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import Foundation


class TableData: ObservableObject {
    @Published var receivedPlaces: [GooglePlace] = []
    @Published var numberOfGuests: Int = 1
    @Published var tableLikedPlaces: [(GooglePlace, Int)] = []
    
    func addLikedPlace(place: GooglePlace) {
        print("Adding liked place \(place.name)")
        DispatchQueue.main.async{
            if let placeIndex = self.tableLikedPlaces.firstIndex(where: {$0.0 == place}) {
                self.tableLikedPlaces[placeIndex].1 += 1
            }
            else {
                self.tableLikedPlaces.append((place, 1))
            }
        }
    }
}
