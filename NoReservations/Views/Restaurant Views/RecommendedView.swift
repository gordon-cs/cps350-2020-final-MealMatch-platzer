//
//  LikedPlacesView.swift
//  NoReservations
//
//  Created by Evan Platzer on 5/3/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct RecommendedView: View {
    @EnvironmentObject var tableData: TableData
    
    var body: some View {
        VStack {
            Text("Recommendations:")
                .font(.title)
                .foregroundColor(.white)
            
            HStack {
                Text("Place")
                
                Spacer()
                
                Text("Liked by")
            }
            .padding(.horizontal)
            .foregroundColor(.white)
            
            List(tableData.tableLikedPlaces, id: \.0.name) { place in
                HStack {
                    Text(place.0.name)
                    
                    Spacer()
                    
                    Text("\(place.1)/\(self.tableData.numberOfGuests)")
                }
            }
        }
    .background(Color("AppBlue"))
        .onAppear() {
            self.tableData.tableLikedPlaces.sort(by: {$0.1 > $1.1})
        }
    }
}

struct RecommendedView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedView()
    }
}
