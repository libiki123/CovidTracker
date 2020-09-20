//
//  ContentView.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-18.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var covidData = CovidDataRequest()
    
    var body: some View {
        TabView{
            RecentView()
                .tabItem {
                    Tab(imageName: "chart.bar", text: "Recent")
            }.tag(0)
        }
    }
}

private struct Tab: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}

