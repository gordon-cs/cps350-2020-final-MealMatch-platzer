//
//  RestaurantCardView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/12/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct RestaurantCardView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RestaurantMapView()
            RestaurantInfoView()
        }
        .shadow(radius: 2)
        .padding(.horizontal)
        .navigationBarTitle("Choose Restaurants", displayMode: .inline)
    }
}

struct RestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCardView()
    }
}
