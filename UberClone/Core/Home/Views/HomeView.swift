//
//  HomeView.swift
//  uberClone
//
//  Created by Rahul shah on 22/04/23.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    var body: some View {
        ZStack(alignment: .bottom)  {
            ZStack(alignment : .top) {
                UberMapViewReprestible(mapState: $mapState)
                    .ignoresSafeArea()
                if mapState == .searching {
                    LocationSearchView(mapState: $mapState)
                }
                else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                mapState = .searching
                            }
                        }
                }
                MapViewActionButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            if(mapState == .locationSelected || mapState == .polyLineAdded) {
                RideRequestView().transition(.move(edge: .bottom))
            }
        }.edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation) {
                location in
                if let location = location {
                    print("DEBUG location is \(location)")
                    locationViewModel.userLocation = location
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
