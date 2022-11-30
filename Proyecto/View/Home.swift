//
//  Home.swift
//  Proyecto
//
//  Created by Ana Casas on 11/29/22.
//  Copyright © 2022 Ana Casas. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        
        ZStack{
            
            VStack(spacing: 10){
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}                    }, label: {
                        
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color("pink"))
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("pink"))
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal,.top])
                
                Divider()
                
                HStack(spacing: 15){
                    TextField("search", text: $HomeModel.search)
                    
                    if HomeModel.search != ""{
                        
                        Button(action: {}, label: {
                            
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                        })
                            .animation(.easeIn)
                    }
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
                Spacer()
            }
            
            HStack{
                
                Menu(homeData: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0: -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }
            .background(
                Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                    .onTapGesture(perform: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                    })
            )
            
            if HomeModel.noLocation{
                Text("Please Enable Location Access In Settings To Further Move On !!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
        .onAppear(perform: {
            
            HomeModel.locationManager.delegate = HomeModel
        })
    }
}
