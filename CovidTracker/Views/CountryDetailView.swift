//
//  CountryDetail.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-24.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct CountryDetailView: View {
    var countryData: CountryData
    
    var body: some View {
        VStack{
            VStack {
                VStack{
                    HStack{
                        Image(countryData.countryCode)
                            .resizable()
                            .frame(width: 26, height: 21, alignment: .center)
                        
                        Text(countryData.country)
                            .fontWeight(.bold)
                        
                    }
                    Divider()
                }
                .padding(.top)
                .padding(.leading)
                .padding(.trailing)
                
                CountryDetailRowView(name: "Population", number: countryData.population.formatNumber())
                CountryDetailRowView(name: "Total Cases", number: countryData.totalConfirmed.formatNumber(), color: .blue)
                CountryDetailRowView(name: "Total Deaths", number: countryData.totalDeaths.formatNumber(), color: .red)
                CountryDetailRowView(name: "Total Recovery", number: countryData.totalRecovered.formatNumber(), color: .green)
                CountryDetailRowView(name: "Fatality rate", number: String(format: "%.2f%%", countryData.fatalityRate), color: .red)
                CountryDetailRowView(name: "Recovery rate", number: String(format: "%.2f%%", countryData.recoveryRate), color: .green)
                
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
                
                CountryDetailRowView(name: "Cases", number: countryData.todayConfirmed.formatNumber(), color: .blue)
                CountryDetailRowView(name: "Deaths", number: countryData.todayDeaths.formatNumber(), color: .red)
            }
            .background(Color("cardsBackgroundGray"))
            .cornerRadius(8)
            .padding(8)
            
            
            Spacer()
        }
        .padding(.top, 50)
        
    }
}

struct CountryDetail_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(countryData: blankCountryData)
    }
}
