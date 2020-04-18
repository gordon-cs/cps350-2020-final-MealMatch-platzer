//
//  MainMenuView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/18/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("Name:", text: $userData.name)
            
            Spacer()
                
                NavigationLink(destination: TableHostView()) {
                    ButtonView(buttonText: "Host a Table")
                }
                .disabled(userData.name.isEmpty)
                
                NavigationLink(destination: SelectTableView()) {
                    ButtonView(buttonText: "Join a Table")
                }
                .disabled(userData.name.isEmpty)
            .padding()
                
            }
        .navigationBarTitle("NoReservations")
        }
    }

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
        .environmentObject(UserData())
    }
}
