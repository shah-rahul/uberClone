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
    @Published var selectedUberLocation: UberLocation?
    @Published var pickUpTime : String?
    @Published var dropOffTime : String?
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
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
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
        guard let coordiante = selectedUberLocation?.coordinate else { return 0.0}
        guard let userLoc = self.userLocation else { return 0.0}
        let userLocation = CLLocation(latitude: userLoc.latitude, longitude: userLoc.longitude)
        let destinationLocation = CLLocation(latitude: coordiante.latitude, longitude : coordiante.longitude)
        let tripDistanceInMeter  = userLocation.distance(from: destinationLocation)
        return type.computePrice(for: tripDistanceInMeter)
    }
    
    
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
            self.cofigurePickUpAndDropOffTime(with: route.expectedTravelTime)
            completion(route)
        }
    }
    func cofigurePickUpAndDropOffTime(with expctedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expctedTravelTime)
    }
    
}

// MARK : MKlocalsearchCoompleterDelegate
extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
