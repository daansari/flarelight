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

public protocol FlarelightDelegate {
    func flarelight(client: Flarelight, didUpdateLocation: CLLocation?)
}

public class Flarelight: NSObject, CLLocationManagerDelegate {
    
    // Operation Queues
    let mainQueue = NSOperationQueue.mainQueue()
    let dispatchQueue = NSOperationQueue()
    
    // Location Management
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // Data Store
    let geofences = [Geofence]()
    let beacons = [Beacon]()
    
    // Closures
    var delegate: FlarelightDelegate?
    
    //MARK: Initializers
    public init(delegate: FlarelightDelegate?) {
        self.delegate = delegate
    }
    
    //MARK: Internal
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
        let _ = locationManager.monitoredRegions.map { locationManager.stopMonitoringForRegion($0) }
        let _ = geofences.map { locationManager.startMonitoringForRegion(regionForGeofence($0)) }
    }
    
    //MARK: LocationManager Delegate
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if let delegate = delegate where status == .Denied {
            return delegate.flarelight(self, didUpdateLocation: nil)
        }
    }
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
        
        if let delegate = delegate {
            delegate.flarelight(self, didUpdateLocation: currentLocation)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: Background Task
    func performBackgroundTask(region: CLRegion, trigger: Trigger) {
        //TODO: Implementation
    }
}
