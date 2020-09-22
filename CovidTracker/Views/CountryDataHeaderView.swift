//
//  ListHeaderView.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-19.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct CountryDataHeaderView: View {
    var body: some View {
        HStack{
            Text("Country")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(width: 110, alignment: .leading)
                .padding(.leading, 10)
            
            Spacer()
            Text("Conf.")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(height: 40)
                .padding(.leading, 5)
            
            Spacer()
            Text("Death")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(height: 40)
                .padding(.leading, 7)
            
            Spacer()
            Text("Recover")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(height: 40)
                .padding(.trailing, 10)
        }
        .background(Color.gray)
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDataHeaderView()
    }
}
