//
//  BottomBarView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/27/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct BottomBarView: View {
    @EnvironmentObject var tableData: TableData
    @EnvironmentObject var tableService: TableService
    @State var showLikedPlaces = false
    @State var restaurantsToChoose: Bool = true
    
    func likePlace() {
        self.tableData.addLikedPlace(place: self.tableData.receivedPlaces[0])
        self.tableService.sendLikedPlace(place: self.tableData.receivedPlaces[0])
        self.tableData.receivedPlaces.removeFirst()
        if self.tableData.receivedPlaces.isEmpty {
            print("Received places empty")
            self.restaurantsToChoose.toggle()
        }
    }
    
    func dislikePlace() {
        self.tableData.receivedPlaces.removeFirst()
        if self.tableData.receivedPlaces.isEmpty {
            print("Received places empty")
            self.restaurantsToChoose.toggle()
        }
    }
    
    var body: some View {
        HStack {
            if self.restaurantsToChoose {
                ButtonView(buttonText: "X", buttonColor: .red)
                    .onTapGesture {
                        self.dislikePlace()
                }
            }
            
            Spacer()
            
            ButtonView(buttonText: "Recommendations", buttonColor: Color("AppBlue"))
                .onTapGesture {
                    self.showLikedPlaces.toggle()
            }
            .disabled(self.tableData.tableLikedPlaces.isEmpty)
            
            Spacer()
            
            if self.restaurantsToChoose {
                ButtonView(buttonText: "✓", buttonColor: .green)
                    .onTapGesture {
                        self.likePlace()
                }
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: self.$showLikedPlaces) {
            RecommendedView().environmentObject(self.tableData)
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
    }
}
