//
//  SearchRadiusView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/22/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct SearchRadiusView: View {
    @EnvironmentObject var userData: UserData
    
    func displaySearchRadius() -> String {
        switch userData.units {
        case "km":
            return "Search Radius: \(Int(userData.searchRadius)) km"
        case "miles":
            return "Search Radius: \(Int(userData.searchRadius / 1.609)) miles"
        default:
            print("Error: unrecognized units for search radius")
            return "Search Radius: \(userData.searchRadius)"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(displaySearchRadius())
                .foregroundColor(Color("AppBlue"))
                .font(.title)
            
            Slider(value: $userData.searchRadius, in: 1...49)
                .accentColor(Color("AppBlue"))
        }
    }
}

struct SearchRadiusView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRadiusView()
    }
}
