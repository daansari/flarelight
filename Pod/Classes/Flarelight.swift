//
//  Flarelight.swift
//  Pods
//
//  Created by Marcus Kida on 6/12/2015.
//
//

import UIKit
import CoreLocation

enum Trigger: UInt32 {
    case Enter = 1, Exit = 2
}

class Flarelight: NSObject, CLLocationManagerDelegate {
    
    // Operation Queues
    let mainQueue = NSOperationQueue.mainQueue()
    let dispatchQueue = NSOperationQueue()
    
    // Location Management
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // Data Store
    let geofences = [Geofence]()
    let beacons = [Beacon]()
    
    func setup () {
        locationManager.delegate = self
    }
    
    func startUpdatingLocation (start: Bool) {
        if start {
            return locationManager.startUpdatingLocation()
        }
        locationManager.stopUpdatingLocation()
    }
    
    func regionForGeofence (geofence: Geofence) -> CLRegion {
        return CLCircularRegion(center: CLLocationCoordinate2DMake(geofence.latitude, geofence.longitude), radius: geofence.radius, identifier: geofence.uuid)
    }

    func cleanup () {
        // Cleanup Geofences
        for (_, region) in locationManager.monitoredRegions.enumerate() {
            locationManager.stopMonitoringForRegion(region)
        }
        for (_, geofence) in geofences.enumerate() {
            locationManager.startMonitoringForRegion(regionForGeofence(geofence))
        }
    }
    
    //MARK: LocationManager Delegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .Denied {
            //TODO: Implement denial of location authorization
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
        
        //TODO: Implement location found closure
        
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: Background Task
    func performBackgroundTask(region: CLRegion, trigger: Trigger) {
        //TODO: Implementation
    }
}
