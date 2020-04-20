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
                .padding()
                .foregroundColor(Color("AppDarkBlue"))
            
            
            Spacer()
            
            NavigationLink(destination: InviteGuestsView(userName: userData.name)) {
                ButtonView(buttonText: "Host a Table", buttonColor: Color("AppBlue"))
            }
            .disabled(userData.name.isEmpty)
            
            NavigationLink(destination: JoinTableView(userName: userData.name)) {
                ButtonView(buttonText: "Join a Table", buttonColor: Color("AppYellow"))
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
