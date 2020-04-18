//
//  HostView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/16/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct TableHostView: View {
    @State private var searchRadius = 1.0
    @State var connectionsLabel: String = ""
    @State var guestName: String = ""
    @EnvironmentObject var userData: UserData
    
    let tableService = TableService()
    
    var body: some View {
        VStack {
            Form{
                Section{
                    Text("Search Radius: \(Int(searchRadius)) km")
                    Slider(value: $searchRadius, in: 1...50)
                }
                
                Section {
                    Text("Guests:")
                    Text(self.guestName)
                }
                
            }
            Spacer()
            
            Button(action: {
                self.tableService.delegate = self
//                self.guestName = self.userData.name
                self.tableService.send(userName: self.userData.name)
            }) {
                ButtonView(buttonText: "Send Name")
            }
            
            NavigationLink(destination: RestaurantCardView()) {
                ButtonView(buttonText: "Choose Restaurant")
            }
        }
        .navigationBarTitle("\(userData.name)'s Table")
    }
}

extension TableHostView: TableServiceDelegate {

    func connectedDevicesChanged(manager: TableService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel = "Connected devices: \(connectedDevices)"
        }
    }
    
    func userNameChanged(manager: TableService, userName: String) {
        OperationQueue.main.addOperation {
            self.guestName = userName
        }
    }
}

struct TableHostView_Previews: PreviewProvider {
    static var previews: some View {
        TableHostView()
            .environmentObject(UserData(name: "Test User"))
    }
}
