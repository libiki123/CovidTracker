//
//  MapContainerView.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-24.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct MapContainerView: View {
    @ObservedObject var covidData = CovidDataRequest()
    
    
    var body: some View {
        
        MapView(countriesData: $covidData.countriesData)
    }
}

struct MapContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MapContainerView()
    }
}
