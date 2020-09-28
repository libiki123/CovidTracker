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
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: CountryDataModel.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \CountryDataModel.totalCases, ascending: false)],
                  predicate: NSPredicate(value: true)) var countriesData: FetchedResults<CountryDataModel>
    
    var body: some View {
        NavigationView{
            VStack{
                
                if(isSearchVisiable){
                    SearchBarView(searchText: $searchText)
                }
                
                GlobalDataCardsView()//globalData: covidData.globalData)
                CountryDataHeaderView()
                
                List{
                    
                    ForEach(countriesData.filter{country in
                        return self.searchText.isEmpty ? true : country.countryName!.lowercased().contains(self.searchText.lowercased())
                    }, id: \.countryName){ (countryData : CountryDataModel) in
                        NavigationLink(destination: CountryDetailView(countryCode: countryData.countryCode!)) {
                            CountryDataRowView(countryCode: countryData.countryCode!)
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
