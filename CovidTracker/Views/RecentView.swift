//
//  RecentView.swift
//  CovidTracker
//
//  Created by Ethan Truong on 2020-09-19.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI
import Foundation

struct RecentView: View {
    @ObservedObject var covidData = CovidDataRequest()
    @State var searchText = ""
    @State var isSearchVisiable = false
    
    var body: some View {
        NavigationView{
            VStack{
                
                if(isSearchVisiable){
                    SearchBarView(searchText: $searchText)
                }
                
                GlobalDataCardsView(globalData: covidData.globalData)
                CountryDataHeaderView()
                
                List{
                    ForEach(covidData.countriesData.filter{country in
                        return self.searchText.isEmpty ? true : country.country.lowercased().contains(self.searchText.lowercased())
                    } , id: \.country) { countryData in
                        NavigationLink(destination: CountryDetailView(countryData: countryData)) {
                            CountryDataRowView(countryData: countryData)
                        }
                    }
                }
                
            }//End of VStack
            .navigationBarTitle("Recent Data", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.isSearchVisiable.toggle()
                    
                    if(!self.isSearchVisiable){
                        self.searchText = ""
                    }
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                })
            )
            
        }//End of NavigationView
    }
}

struct RecentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentView()
    }
}
