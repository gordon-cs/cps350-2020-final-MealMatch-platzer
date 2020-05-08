//
//  LocationManager.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/23/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var status: CLAuthorizationStatus?
    @Published var location: CLLocation?
        
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        print("Location updated to \(location.coordinate.description)")
//        self.dataProvider.fetchPlaces(near: location.coordinate, radius: userData.searchRadius) { places in
//            self.places = places
//        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
    }
}
