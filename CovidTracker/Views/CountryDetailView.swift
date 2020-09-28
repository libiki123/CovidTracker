//
//  CountryDetail.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-24.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct CountryDetailView: View {
    var fetchRequest: FetchRequest<CountryDataModel>
    var countryData: FetchedResults<CountryDataModel> { fetchRequest.wrappedValue }
    
    init(countryCode: String) {
        fetchRequest = FetchRequest<CountryDataModel>(entity: CountryDataModel.entity(),
                                                      sortDescriptors: [],
                                                      predicate: NSPredicate(format: "countryCode = %@", countryCode))
    }
    
    var body: some View {
        VStack{
            VStack {
                VStack{
                    HStack{
                        Image(countryData.first!.countryCode!)
                            .resizable()
                            .frame(width: 26, height: 21, alignment: .center)
                        
                        Text(countryData.first!.countryName!)
                            .fontWeight(.bold)
                        
                    }
                    Divider()
                }
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
                
                CountryDetailRowView(name: "Population", number: countryData.first!.population.formatNumber())
                CountryDetailRowView(name: "Total Cases", number: countryData.first!.totalCases.formatNumber(), color: .blue)
                CountryDetailRowView(name: "Total Deaths", number: countryData.first!.totalDeaths.formatNumber(), color: .red)
                CountryDetailRowView(name: "Total Recovery", number: countryData.first!.totalRecovered.formatNumber(), color: .green)
                CountryDetailRowView(name: "Fatality rate", number: String(format: "%.2f%%", countryData.first!.fatalityRate), color: .red)
                CountryDetailRowView(name: "Recovery rate", number: String(format: "%.2f%%", countryData.first!.recoveryRate), color: .green)
                
                VStack{
                    HStack{
                        Text("Today Data")
                            .fontWeight(.medium)
                    }
                    Divider()
                }
                .padding(.top, 5)
                .padding(.leading)
                .padding(.trailing)
                
                CountryDetailRowView(name: "Cases", number: countryData.first!.todayCases.formatNumber(), color: .blue)
                CountryDetailRowView(name: "Deaths", number: countryData.first!.todayDeaths.formatNumber(), color: .red)
            }
            .background(Color("cardsBackgroundGray"))
            .cornerRadius(8)
            .padding(8)
            
            
            Spacer()
        }
        .padding(.top, 50)
        
    }
}

