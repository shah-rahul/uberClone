//
//  MapViewActionButton.swift
//  uberClone
//
//  Created by Rahul shah on 24/04/23.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var showLocationViewActive : Bool
    var body: some View {
        Button {
            withAnimation(.spring()) {
                showLocationViewActive.toggle()
            }
        } label : {
            Image(systemName: showLocationViewActive ? "arrow.left" : "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black , radius: 3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(showLocationViewActive: .constant(true))
    }
}
