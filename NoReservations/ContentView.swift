//
//  ContentView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/12/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        NavigationView {
            MainMenuView()
            
        }
        .navigationBarColor(UIColor(named: "AppBlue"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
