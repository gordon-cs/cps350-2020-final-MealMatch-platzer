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
            
            List(tableData.tableLikedPlaces.indices) { index in
                HStack {
                    Text(self.tableData.tableLikedPlaces[index].0.name)
                    
                    Spacer()
                    
                    Text("\(self.tableData.tableLikedPlaces[index].1)/\(self.tableData.numberOfGuests)")
                }
            }
        }
    .background(Color("AppBlue"))
    }
}

struct RecommendedView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedView()
    }
}
