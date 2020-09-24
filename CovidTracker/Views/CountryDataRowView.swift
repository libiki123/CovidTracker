//
//  CountryDataRowView.swift
//  CovidTracker
//
//  Created by Ethan Truong on 2020-09-21.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct CountryDataRowView: View {
    
    var countryData: CountryData
    
    var body: some View {
        HStack{
            Image(countryData.countryCode)
                .resizable()
                .frame(width: 18, height: 15, alignment: .center)
            
            Text(countryData.country)
                .fontWeight(.medium)
                .font(.system(size: 15))
                .lineLimit(2)
                .frame(width: 82, alignment: .leading)
            
            Spacer()
            Text(countryData.totalConfirmed.formatNumber())
                .font(.system(size: 13))
                .frame(height: 40, alignment: .center)
                .padding(.leading, 5)
            
            Spacer()
            Text(countryData.totalDeaths.formatNumber())
                .font(.system(size: 13))
                .frame(height: 40, alignment: .center)
                .foregroundColor(.red)
                .padding(.leading, 5)
            
            Spacer()
            Text(countryData.totalRecovered.formatNumber())
                .font(.system(size: 13))
                .frame(height: 40, alignment: .center)
                .foregroundColor(.green)
                .padding(.leading, 5)
        }

    }
}

struct CountryDataRowView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDataRowView(countryData: blankCountryData)
    }
}
