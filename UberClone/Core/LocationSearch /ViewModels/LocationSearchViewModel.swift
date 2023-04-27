//
//  LocationSearchViewModel.swift
//  uberClone
//
//  Created by Rahul shah on 24/04/23.
//
import MapKit
import Foundation

class LocationSearchViewModel: NSObject, ObservableObject{
    // mark : properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate : CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment = "" {
        didSet {
            print("DEBUG : query fragment is  \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    var userLocation : CLLocationCoordinate2D?
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
        
    }
    
    //
    func selectLocation ( _ localSearch : MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) {
            response, error in
            if let error = error {
                print("some error occured \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("debug coornidate : \(coordinate)")
        }
        
    }
    func locationSearch (forLocalSearchCompletion localSearch : MKLocalSearchCompletion, completion : @escaping MKLocalSearch.CompletionHandler ) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    func computeRidePrice(forType type : RideType) -> Double {
        guard let coordiante = selectedLocationCoordinate else { return 0.0}
        guard let userLoc = self.userLocation else { return 0.0}
        let userLocation = CLLocation(latitude: userLoc.latitude, longitude: userLoc.longitude)
        let destinationLocation = CLLocation(latitude: coordiante.latitude, longitude : coordiante.longitude)
        let tripDistanceInMeter  = userLocation.distance(from: destinationLocation)
        return type.computePrice(for: tripDistanceInMeter)
    }
}

// MARK : MKlocalsearchCoompleterDelegate
extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
