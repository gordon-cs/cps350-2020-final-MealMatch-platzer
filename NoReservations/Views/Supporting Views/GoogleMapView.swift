//
//  GoogleMapView.swift
//  NoReservations
//
//  Created by Evan Platzer on 4/12/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    
    var place: GooglePlace
    
    let marker : GMSMarker = GMSMarker()
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        mapView.clear()
        marker.position = place.coordinate
        marker.title = place.name
        marker.snippet = place.address
        marker.map = mapView
    }
    
    
}
