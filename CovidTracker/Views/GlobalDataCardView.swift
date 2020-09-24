//
//  GlobalDataCards.swift
//  CovidTracker
//
//  Created by Ethan Truong on 2020-09-23.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI

struct GlobalDataCardView: View {
    var name: String = "Confirmsed"
    var number: String = "Err"
    var color: Color = .primary
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack{
                Text(self.number)
                    .font(.subheadline)
                    .padding(5)
                    .foregroundColor(self.color)
                
                Text(self.name)
                    .font(.body)
                    .padding(5)
                    .foregroundColor(self.color)
            }//End of VStack
            .frame(width: geometry.size.width, height: 80, alignment: .center)
            .background(Color("cardsBackgroundGray"))
            .cornerRadius(8.8)
        }//End of Geometry
    }
}

struct GlobalDataCards_Previews: PreviewProvider {
    static var previews: some View {
        GlobalDataCardView()
    }
}
