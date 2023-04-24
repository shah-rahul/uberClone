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
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment = "" {
        didSet {
            print("DEBUG : query fragment is  \(queryFragment)")
            searchCompleter.queryFragment = queryFragment
        }
    }
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
        
    }
}

// MARK : MKlocalsearchCoompleterDelegate
extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
