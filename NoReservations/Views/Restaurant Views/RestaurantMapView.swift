//
//  RestaurantMapView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/16/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct RestaurantMapView: View {
    var place: GooglePlace
    
    var body: some View {
        GoogleMapView(place: place)
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
