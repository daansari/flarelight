//
//  Geofence.swift
//  Pods
//
//  Created by Marcus Kida on 6/12/2015.
//
//

import Foundation

struct Geofence {
    let uuid: String
    
    let latitude: Double
    let longitude: Double
    let radius: Double
    
    init(uuid: String, latitude: Double, longitude: Double, radius: Double) {
        self.uuid = uuid
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
    }
}
