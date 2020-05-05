//
//  RestaurantCardView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/12/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import CoreLocation
import SwiftUI

struct RestaurantCardView: View {
    @EnvironmentObject var tableData: TableData
    
    var body: some View {
        ZStack(alignment: .leading) {
            RestaurantMapView(place: self.tableData.receivedPlaces[0])
            RestaurantInfoView(place: self.tableData.receivedPlaces[0])
        }
    .padding(10)
        .shadow(radius: 5)
        .cornerRadius(10)
        .navigationBarTitle("Choose Restaurants", displayMode: .inline)
    }
}
