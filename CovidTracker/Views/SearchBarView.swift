//
//  SearchBar.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-23.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        
        HStack {
            TextField("Country...", text: $searchText)
                .padding()
        }
        .frame(height: 50)
        .background(Color("cardsBackgroundGray"))
    }
}

