//
//  CovidDataRequest.swift
//  CovidTracker
//
//  Created by Ethan Truong on 2020-09-19.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum CovidDataRequestError: Error {
    case notFound
    case forbidden
    case unauthorized
}

class CovidDataRequest: ObservableObject{
    @Published var globalData: GlobalData!
    @Published var countriesData: [CountryData]! = []
    
    init() {
        self.getAllData()
    }
    
    func getAllData() {
        AF.request("https://api.covid19api.com/summary").responseJSON { response in
            let result = response.data
            
            if result != nil{
                let sumaryJson = JSON(result!)
                let globalJson = JSON(sumaryJson["Global"])
                let countriesJson = JSON(sumaryJson["Countries"])
                
                self.globalData =  GlobalData(
                    newDeaths: Int64(globalJson["NewDeaths"].intValue),
                    newRecovered: Int64(globalJson["NewRecovered"].intValue),
                    totalDeaths: Int64(globalJson["TotalDeaths"].intValue),
                    totalRecovered: Int64(globalJson["TotalRecovered"].intValue),
                    newConfirmed: Int64(globalJson["NewConfirmed"].intValue),
                    totalConfirmed: Int64(globalJson["TotalConfirmed"].intValue))
                
                for (_, country):(String, JSON) in countriesJson {
                    let countryData = CountryData(
                        totalRecovered: Int64(country["TotalRecovered"].intValue),
                        countryCode: country["CountryCode"].stringValue,
                        totalDeaths: Int64(country["TotalDeaths"].intValue),
                        totalConfirmed: Int64(country["TotalConfirmed"].intValue),
                        date: country["Date"].toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")!,
                        newRecovered: Int64(country["NewRecovered"].intValue),
                        newConfirmed: Int64(country["NewConfirmed"].intValue),
                        country: country["Country"].stringValue,
                        slug: country["Slug"].stringValue,
                        newDeaths: Int64(country["NewDeaths"].intValue))
                    
                    self.countriesData.append(countryData)
                }
            }
        }
    }
    
}

extension JSON {
  func toDate(dateFormat: String) -> Date? {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat

    let date: Date? = dateFormatter.date(from: self.stringValue)
    return date
    }
}
