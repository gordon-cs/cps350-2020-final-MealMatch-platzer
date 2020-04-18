//
//  SelectTableView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/17/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct SelectTableView: View {
    @State var guestName = ""
    
    var body: some View {
        VStack {
            List {
                Text("Practicum")
            }
            
            NavigationLink(destination: RestaurantCardView()) {
                ButtonView(buttonText: "Join Table")
            }
        }
    .padding()
    .navigationBarTitle("Tables")
    }
}

struct SelectTableView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTableView()
    }
}
