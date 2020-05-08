//
//  NameTableView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/16/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct NameTableView: View {
    @State var tableName: String = ""
    @State private var action: Int? = 0
    
    var body: some View {
        VStack {
            TextField("Table name", text: $tableName)
                .disableAutocorrection(true)
            
            NavigationLink(destination: HostView(tableName: tableName), tag: 1, selection: $action) {
                EmptyView()
            }
            
            Button(action: { self.action = 1 }) {
                ButtonView(buttonText: "Create Table")
            }
            .disabled(tableName.isEmpty)
        }
    .navigationBarTitle("Name Your Table")
    }
}

struct NameTableView_Previews: PreviewProvider {
    static var previews: some View {
        NameTableView()
    }
}
