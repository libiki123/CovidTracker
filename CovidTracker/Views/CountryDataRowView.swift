//
//  CountryDataRowView.swift
//  CovidTracker
//
//  Created by Ethan Truong on 2020-09-21.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct CountryDataRowView: View {
    var fetchRequest: FetchRequest<CountryDataModel>
    var countryData: FetchedResults<CountryDataModel> { fetchRequest.wrappedValue }
    
    init(countryCode: String) {
        fetchRequest = FetchRequest<CountryDataModel>(entity: CountryDataModel.entity(),
                                                      sortDescriptors: [],
                                                      predicate: NSPredicate(format: "countryCode = %@", countryCode))
    }
    
    var body: some View {
        
        HStack{
            //Text("a")
            Image(countryData.first!.countryCode!)
                .resizable()
                .frame(width: 18, height: 15, alignment: .center)

            Text(countryData.first!.countryName!)
                .fontWeight(.medium)
                .font(.system(size: 15))
                .lineLimit(2)
                .frame(width: 82, alignment: .leading)

            Spacer()
            Text(countryData.first!.totalCases.formatNumber())
                .font(.system(size: 13))
                .frame(height: 40, alignment: .center)
                .padding(.leading, 5)

            Spacer()
            Text(countryData.first!.totalDeaths.formatNumber())
                .font(.system(size: 13))
                .frame(height: 40, alignment: .center)
                .foregroundColor(.red)
                .padding(.leading, 5)

            Spacer()
            Text(countryData.first!.totalRecovered.formatNumber())
                .font(.system(size: 13))
                .frame(height: 40, alignment: .center)
                .foregroundColor(.green)
                .padding(.leading, 5)
        }

    }
}
