//
//  LocationSearchActivationView.swift
//  uberClone
//
//  Created by Rahul shah on 24/04/23.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            Rectangle().fill(Color.black)
                .frame(width:  8, height: 8)
                .padding(.horizontal)
            
            Text("Where To")
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
           Rectangle()
            .fill(Color.white)
            .shadow(color: .black, radius: 3)
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
