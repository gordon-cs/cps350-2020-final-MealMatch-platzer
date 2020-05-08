//
//  BottomBarView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/27/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct BottomBarView: View {
    @Binding var showLikedPlaces: Bool
    var restaurantsToChoose: Bool
    var likePlaceCallback: () -> Void
    var dislikePlaceCallback: () -> Void
    
    var body: some View {
        HStack {
            if self.restaurantsToChoose {
                ButtonView(buttonText: "X", buttonColor: .red)
                    .onTapGesture {
                        self.dislikePlaceCallback()
                }
            }
                        
            ButtonView(buttonText: "Liked", buttonColor: Color("AppBlue"))
                .onTapGesture {
                    self.showLikedPlaces.toggle()
            }
                    
            if self.restaurantsToChoose {
                ButtonView(buttonText: "✓", buttonColor: .green)
                    .onTapGesture {
                        self.likePlaceCallback()
                }
            }
        }
        .padding(.horizontal)
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(showLikedPlaces: .constant(false), restaurantsToChoose: false, likePlaceCallback: {}, dislikePlaceCallback: {})
    }
}
