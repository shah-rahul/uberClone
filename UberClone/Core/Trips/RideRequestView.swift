//
//  RideRequestView.swift
//  uberClone
//
//  Created by Rahul shah on 25/04/23.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 10)
            // trip info view
            HStack {
                //listview
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 8, height: 8)
                }
                VStack (alignment: .leading, spacing: 24) {
                    HStack {Text("Current Location").font(.system(size: 16, weight:  .semibold)).foregroundColor(.gray)
                        Spacer()
                        Text("1:30 PM").font(.system(size:14, weight: .semibold)).foregroundColor(.gray)
                        
                    }
                    .padding(.bottom, 10)
                    HStack {Text("Starbhakts").font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                        Spacer()
                        Text("1:45 PM").font(.system(size:14, weight: .semibold)).foregroundColor(.black)
                        
                    }
                }.padding(.leading, 8)
                
            }.padding()
            Divider()
            // ride type seleciton
               Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 22) {
                    ForEach( RideType.allCases) {
                        type in
                        VStack(alignment: .leading,  spacing : 4) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            VStack(alignment: .leading ,  spacing : 4){
                                Text(type.description).font(.system(size:14, weight: .semibold)).foregroundColor(type == selectedRideType ? .white : .black)
                                Text("100 rs  ").font(.system(size:14, weight: .semibold)).foregroundColor(type == selectedRideType ? .white : .black)
                            }.padding(16)
                                
                           
                        }
                      
                        .frame(width: 112, height: 140)
                     
                        .background(Color(type == selectedRideType ? .systemBlue : .systemGroupedBackground))
                        .scaleEffect(type == selectedRideType ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedRideType = type
                            }
                        }
                    }
                }
            }.padding(.horizontal)
            Divider().padding(.vertical,8)
            // payment options
            HStack(spacing: 12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                Text("**** 7745")
                    .fontWeight(.bold)
               Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }.frame(height: 50)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(10)
                .padding(.horizontal)
            Divider()
            // request ride button
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width:UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    
            }
             
        }.padding(.bottom,14).background(.white).cornerRadius(20)    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
