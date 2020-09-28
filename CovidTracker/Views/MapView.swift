//
//  MapView.swift
//  CovidTracker
//
//  Created by Nikki Truong on 2020-09-24.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit
import MapKit

struct MapView: UIViewRepresentable {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: CountryDataModel.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(value: true)) var countriesData: FetchedResults<CountryDataModel>
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        var allAnnotations: [CovidCaseAnnotation] = []

        for country in countriesData {
            let title = country.countryName! +
                "\n Cases: \(country.totalCases.formatNumber())" +
                "\n Deaths: \(country.totalDeaths.formatNumber())" +
                "\n Recovered: \(country.totalRecovered.formatNumber())"
            let coordinate = CLLocationCoordinate2D(latitude: country.latitude, longitude: country.longtitude)

            allAnnotations.append(CovidCaseAnnotation(title: title, coordinate: coordinate))
        }

        uiView.annotations.forEach{ uiView.removeAnnotation($0)}
        uiView.addAnnotations(allAnnotations)
    }

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView{
        return MKMapView()
    }
    
}

class CovidCaseAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.coordinate = coordinate
    }
}
