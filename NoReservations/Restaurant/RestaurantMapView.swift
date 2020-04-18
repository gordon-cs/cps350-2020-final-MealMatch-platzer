//
//  RestaurantMapView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/16/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct RestaurantMapView: View {
    var body: some View {
        GoogleMapView()
        .overlay(
            Rectangle()
            .fill (
                LinearGradient(
                    gradient: Gradient(
                        colors: [.clear, .black]
                    ),
                    startPoint: .center,
                    endPoint: .bottom)
                )
                .clipped()
        )
        .cornerRadius(10, antialiased: true)
    }
}

struct RestaurantMapView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantMapView()
    }
}
