//
//  RestaurantImageView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/12/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct RestaurantImageView: View {
    var body: some View {
        Image("castle_map")
        .resizable()
        .overlay (
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

struct RestaurantImageView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantImageView()
    }
}
