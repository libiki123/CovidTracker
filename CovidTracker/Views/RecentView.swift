//
//  RecentView.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-19.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI
import Foundation

struct RecentView: View {
    @ObservedObject var covidData = CovidDataRequest()
    @State var searchText = ""
    
    var body: some View {
        NavigationView{
            VStack{
                CountryDataHeaderView()
                
                List{
                    ForEach(covidData.countriesData, id: \.country) { countryData in

                        CountryDataRowView(countryData: countryData)
                    }
                }
            }//End of VStack
        }//End of NavigationView
    }
}

struct RecentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentView()
    }
}
