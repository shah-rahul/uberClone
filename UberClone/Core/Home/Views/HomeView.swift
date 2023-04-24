//
//  HomeView.swift
//  uberClone
//
//  Created by Rahul shah on 22/04/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = false
    var body: some View {
        ZStack(alignment : .top) {
            UberMapViewReprestible()
                .ignoresSafeArea()
            if showLocationSearchView {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
            }
            else{
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showLocationSearchView.toggle()
                        }
                    }
            }
            MapViewActionButton(showLocationViewActive: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
