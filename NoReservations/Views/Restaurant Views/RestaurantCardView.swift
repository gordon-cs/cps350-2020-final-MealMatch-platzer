//
//  RestaurantCardView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/12/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import CoreLocation
import SwiftUI

struct RestaurantCardView: View {
    var place: GooglePlace
    var likePlaceCallback: () -> Void
    var dislikePlaceCallback: () -> Void
    @State var drag: CGFloat = 0
    @State var degree: Double = 0
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RestaurantMapView(place: self.place)
                RestaurantInfoView(place: self.place)
            }
            .padding(10)
            .shadow(radius: 5)
            .cornerRadius(10)
            .gesture(DragGesture()
                
            .onChanged({ (value) in
                
                if value.translation.width > 0{
                    
                    if value.translation.width > 30{
                        self.drag = value.translation.width
                        self.degree = 12
                    }
                    else{
                        self.drag = value.translation.width
                        self.degree = 0
                    }
                }
                else{
                    
                    if value.translation.width < -30{
                        self.drag = value.translation.width
                        self.degree = -12
                    }
                    else{
                        self.drag = value.translation.width
                        self.degree = 0
                    }
                }
                
            }).onEnded({ (value) in
                
                if self.drag > 0{
                    
                    if self.drag > geo.size.width / 2 - 40{
                        self.drag = 0
                        self.degree = 0
                        self.likePlaceCallback()
                    }
                    else{
                        self.drag = 0
                        self.degree = 0
                    }
                }
                else{
                    
                    if -self.drag > geo.size.width / 2 - 40{
                        self.drag = 0
                        self.degree = 0
                        self.dislikePlaceCallback()
                    }
                    else{
                        self.drag = 0
                        self.degree = 0
                    }
                }
                
            })
            ).offset(x: self.drag)
                .scaleEffect(abs(self.drag) > 100 ? 0.8 : 1)
                .rotationEffect(.init(degrees:self.degree))
                .animation(.spring())
        }
        .navigationBarTitle("Choose Restaurants", displayMode: .inline)
    }
}
