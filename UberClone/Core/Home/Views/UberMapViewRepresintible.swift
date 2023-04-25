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
    @Binding var mapState : MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    func makeUIView(context: Context) -> some UIView {
        mapView.isRotateEnabled = false
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView (_ uiView: UIViewType, context: Context) {
        print("DEBUG MAP STATE IS \(mapState)")
        
        switch mapState {
        case .noInput :
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searching:
            break
        case .locationSelected:
            if let coordinate = viewModel.selectedLocationCoordinate {
                context.coordinator.addAndSelectAnnotaiton(withCoodinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        }
        
    
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewReprestible  {
    class MapCoordinator : NSObject, MKMapViewDelegate {
        // mark : properties
        var currentRegion: MKCoordinateRegion?
        var userLocationCoordinate : CLLocationCoordinate2D?
        let parent : UberMapViewReprestible
    // mark : life cycle
        init(parent: UberMapViewReprestible) {
            self.parent = parent
            super.init()
        }
    // mark : mapview delegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center : CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
            
            
            
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
           let polyLine =  MKPolylineRenderer(overlay: overlay)
            polyLine.strokeColor = .black
            polyLine.lineWidth = 6
            return polyLine
        }
    // mark : helpers
        func addAndSelectAnnotaiton(withCoodinate coordinate : CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
    // MARK : polyliner builder
        
        func configurePolyline(withDestinationCoordinate coordinate : CLLocationCoordinate2D) {
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) {
                route in
                self.parent.mapView.addOverlay(route.polyline)
                
                
            }
        }
        
        
    // mark : route handler
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destinationCoordinate : CLLocationCoordinate2D, completion: @escaping(MKRoute)-> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destinationPlacemark)
            let directions = MKDirections(request: request)
            directions.calculate {
                response, error in
                if let error =  error {
                    print("DEBUG: falied to get coodintes : \(error.localizedDescription)")
                    return
                }
                guard let route = response?.routes.first else {return}
                completion(route)
            }
        }
        // mark mapView clearing
        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
            
        }
    }
}
