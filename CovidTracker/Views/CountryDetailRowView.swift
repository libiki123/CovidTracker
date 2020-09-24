//
//  CountryDetailRowView.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-24.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct CountryDetailRowView: View {
    var name: String = "Confirmsed"
    var number: String = "Err"
    var color: Color = .primary
    
    var body: some View {
        
        VStack{
            HStack{
                Text(self.name)
                    .font(.body)
                    .padding(5)
                
                Spacer()
                Text(self.number)
                    .font(.body)
                    .padding(5)
                    .foregroundColor(self.color)
            }
            Divider()
        }//End of VStack
        .padding(.leading)
        .padding(.trailing)
        
    }
}

struct CountryDetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailRowView()
    }
}
