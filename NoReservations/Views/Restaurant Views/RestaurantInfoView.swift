//
//  RestaurantInfoView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/12/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct RestaurantInfoView: View {
    var place: GooglePlace
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(place.name)
                .font(.title)
                .fontWeight(.regular)
                .foregroundColor(.white)
            Text(place.address)
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.white)
            
        }
    .padding()
    }
}
