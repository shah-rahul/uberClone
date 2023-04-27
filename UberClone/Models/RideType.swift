//
//  RideType.swift
//  uberClone
//
//  Created by Rahul shah on 26/04/23.
//

import Foundation

enum RideType : Int, CaseIterable, Identifiable {
    case uberX
    case uberBlack
    case uberXl
    
    
    var id : Int {return rawValue}
    
    var description: String {
        switch self {
        case .uberBlack : return "UberBlack"
        case .uberX : return "UberX"
        case .uberXl :return "UberXl"
        }
    }
    var imageName: String {
        switch self {
        case .uberBlack : return "uber-black"
        case .uberX : return "uber-x"
        case .uberXl :return "uber-x"
        }
    }
    
    var baseFare : Double {
        switch self{
        case .uberX : return 100
        case .uberXl : return 150
        case .uberBlack: return 200
        }
    }
    
    func computePrice(for distanceInMeteres : Double)-> Double {
        let distanceInKm = distanceInMeteres / 1000;
        switch self{
        case .uberX : return distanceInKm * 10 + baseFare;
        case .uberXl : return distanceInKm * 15 + baseFare;
        case .uberBlack: return distanceInKm * 20 + baseFare;
        }
    }
}
