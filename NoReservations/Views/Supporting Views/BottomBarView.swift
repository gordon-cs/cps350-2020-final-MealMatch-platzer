//
//  BottomBarView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/27/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct BottomBarView: View {
    @Binding var places: [GooglePlace]
    @Binding var liked: [GooglePlace]
    
    func likePlace() {
        self.liked.append(self.places.first!)
        self.places.removeFirst()
    }
    
    func dislikePlace() {
        self.places.removeFirst()
    }
    
    var body: some View {
        HStack {
            ButtonView(buttonText: "X", buttonColor: .red)
                .onTapGesture {
                    self.dislikePlace()
            }
            
            Spacer()
            
            ButtonView(buttonText: "✓", buttonColor: .green)
                .onTapGesture {
                    self.likePlace()
            }
        }
        .padding(.horizontal)
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(places: .constant([]), liked: .constant([]))
    }
}
