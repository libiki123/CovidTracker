//
//  GlobalView.swift
//  CovidTracker
//
//  Created by Ethan Truong on 2020-09-23.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct GlobalDataCardsView: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: GlobalDataModel.entity(), sortDescriptors: []) var gbData: FetchedResults<GlobalDataModel>
    
    var body: some View {

        VStack{
            if(!gbData.isEmpty){
                HStack{
                    GlobalDataCardView(name: "Cases", number: gbData.first!.totalCases.formatNumber(), color: .black)
                    GlobalDataCardView(name: "Recovery", number: gbData.first!.totalRecovered.formatNumber(), color: .green)
                    GlobalDataCardView(name: "Deaths", number: gbData.first!.totalDeaths.formatNumber(), color: .red)
                }// End of HStack

                HStack{
                    GlobalDataCardView(name: "Death R.", number: String(format: "%.2f%%",
                            (100 * Double(gbData.first!.totalDeaths)) / Double(gbData.first!.totalCases)), color: .red)
                    GlobalDataCardView(name: "Critical", number: gbData.first!.totalCritical.formatNumber(), color: .yellow)
                    GlobalDataCardView(name: "Recovery R.", number: String(format: "%.2f%%",
                            (100 * Double(gbData.first!.totalRecovered)) / Double(gbData.first!.totalCases)), color: .green)
                }// End of HStack
            }
        }//End of VStack
        .frame(height: 170)
        .padding(10)
    }
}

struct GlobalView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalDataCardsView()//globalData: blankGlobalData)
    }
}
