//
//  ButtonView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/16/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    @Environment(\.isEnabled) var isEnabled
    var buttonText: String
    
    var body: some View {
        Text(buttonText)
        .padding()
            .background(isEnabled ? Color.blue : Color.gray)
        .foregroundColor(Color.white)
        .cornerRadius(40)
        .padding()
            .shadow(radius: isEnabled ? 5 : 0)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonText: "Click Here")
    }
}
