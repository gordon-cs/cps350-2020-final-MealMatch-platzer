//
//  RestaurantInfoView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/12/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct RestaurantInfoView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("The Castle: A Board Game Cafe")
                .font(.title)
                .fontWeight(.regular)
                .foregroundColor(.white)
            Text("Beverly")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.white)
            
        }
    .padding()
    }
}

struct RestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoView()
    }
}
