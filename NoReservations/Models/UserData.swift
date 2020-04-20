//
//  UserData.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/18/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var name: String = ""
}
