//
//  LocationManager.swift
//  uberClone
//
//  Created by Rahul shah on 22/04/23.
//
import CoreLocation

class LocationManager : NSObject , ObservableObject {
    private let locationManagar = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation : CLLocationCoordinate2D?
    override init() {
        super.init()
        locationManagar.delegate = self
        locationManagar.desiredAccuracy = kCLLocationAccuracyBest
        locationManagar.requestWhenInUseAuthorization()
        locationManagar.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location =  locations.first else {return}
        self.userLocation = location.coordinate
        locationManagar.stopUpdatingLocation()
    }
}

