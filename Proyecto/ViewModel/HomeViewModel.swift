//
//  HomeViewModel.swift
//  Proyecto
//
//  Created by Ana Casas on 11/29/22.
//  Copyright © 2022 Ana Casas. All rights reserved.
//

import SwiftUI
import CoreLocation

class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    @Published var showMenu = false
    
    func locationManagerDidChangeAuthorization(_manager: CLLocationManager){
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            guard let safeData = res else{return}
            var address = ""
            
            address += safeData.first?.name ?? ""
            address += " ,"
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
    }
}
}
