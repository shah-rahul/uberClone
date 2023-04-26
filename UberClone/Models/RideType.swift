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
    
    
}
