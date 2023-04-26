//
//  MapViewActionButton.swift
//  uberClone
//
//  Created by Rahul shah on 24/04/23.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState : MapViewState
    @EnvironmentObject   var viewModel  : LocationSearchViewModel
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label : {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black , radius: 3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("DEBUG : NO INPUT")
        case .locationSelected :
            mapState  = .noInput
            print("DEBUG : LOCATION SELECTED")
        case .searching:
            mapState  = .noInput
            print("DEBUG : SEARCHING")
            viewModel.selectedLocationCoordinate = nil
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected, .searching :
          return    "arrow.left"
       
        }
    }
}
struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
