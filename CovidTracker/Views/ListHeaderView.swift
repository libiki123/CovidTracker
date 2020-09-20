//
//  ListHeaderView.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-19.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct ListHeaderView: View {
    var body: some View {
        HStack{
            Text("Country")
                .fontWeight(.bold)
                .font(.subheadline)
                .frame(width: 110, alignment: .leading)
                .padding(.leading, 15)
        }
    }
}

struct ListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ListHeaderView()
    }
}
