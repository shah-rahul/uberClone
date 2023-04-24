//
//  UberMapViewRepresintible.swift
//  uberClone
//
//  Created by Rahul shah on 22/04/23.
//
import SwiftUI
import MapKit
import Foundation

struct UberMapViewReprestible : UIViewRepresentable {
    let mapView = MKMapView()
    let locationMangaer = LocationManager()
    @EnvironmentObject var viewModel : LocationSearchViewModel
    func makeUIView(context: Context) -> some UIView {
        mapView.isRotateEnabled = false
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocation = viewModel.selectedLocation {
            print("debug selected location \(selectedLocation)")
        }
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewReprestible  {
    class MapCoordinator : NSObject, MKMapViewDelegate {
        let parent : UberMapViewReprestible
        init(parent: UberMapViewReprestible) {
            self.parent = parent
            super.init()
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center : CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            parent.mapView.setRegion(region, animated: true)
        }
    }
}
