//
//  MainMenuView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/18/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI
import Combine

struct MainMenuView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var tableData: TableData
    
    @State var keyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            
            if self.keyboardHeight == 0 {
                Image("logo")
                .resizable()
                .scaledToFit()
            }
                        
            HStack {
                Text("Name:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("AppBlue"))
                
                TextField("Enter name", text: $userData.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color("AppBlue"))
                    
            }
            .padding()
                .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
            
            Spacer()
            
            NavigationLink(
                destination: TableHostView()
                    .environmentObject(TableService(userName: userData.name))
            ) {
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
