//
//  Guests.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/18/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Guest: Identifiable, ObservableObject {
    
    init(id: MCPeerID, name: String, state: MCSessionState = MCSessionState.notConnected) {
        self.id = id
        self.name = name
        self.state = state
    }
    
    var id: MCPeerID
    var name: String
    var state: MCSessionState
}
