//
//  uberCloneApp.swift
//  uberClone
//
//  Created by Rahul shah on 22/04/23.
//

import SwiftUI

@main
struct uberCloneApp: App {
    @StateObject  var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(locationViewModel)
        }
    }
}
