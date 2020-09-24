//
//  GlobalView.swift
//  CovidTracker
//
//  Created by Ethan Truong on 2020-09-23.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct GlobalDataCardsView: View {
    var globalData: GlobalData
    
    var body: some View {
        VStack{
            HStack{
                GlobalDataCardView(name: "Cases", number: globalData.totalCases.formatNumber(), color: .black)
                GlobalDataCardView(name: "Recovery", number: globalData.totalRecovered.formatNumber(), color: .green)
                GlobalDataCardView(name: "Deaths", number: globalData.totalDeaths.formatNumber(), color: .red)
            }// End of HStack

            HStack{
                GlobalDataCardView(name: "Death %", number: String(format: "%.2f", globalData.fatalityRate), color: .red)
                GlobalDataCardView(name: "Critical", number: globalData.totalCritical.formatNumber(), color: .yellow)
                GlobalDataCardView(name: "Recovery %", number: String(format: "%.2f", globalData.recoveryRate), color: .green)
            }// End of HStack

        }//End of VStack
        .frame(height: 170)
        .padding(10)
    }
}

struct GlobalView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalDataCardsView(globalData: blankGlobalData)
    }
}
