//
//  TotalData.swift
//  CovidTracker
//
//  Created by Ethan Truong on 2020-09-19.
//  Copyright © 2020 EthanTruong. All rights reserved.
//

import Foundation

struct GlobalData {
    let newDeaths: Int64
    let newCases: Int64
    let totalDeaths: Int64
    let totalCases: Int64
    let totalCritical: Int64
    let totalRecovered: Int64
    
    var fatalityRate: Double {
        return (100 * Double(totalDeaths)) / Double(totalCases)
    }
    
    var recoveryRate: Double {
        return (100 * Double(totalRecovered)) / Double(totalCases)
    }
}

struct CountryData {
    let countryName: String
    let countryCode: String
    let population: Int64
    
    let latitude: Double
    let longtitude: Double
    
    let fatalityRate: Double
    let recoveryRate: Double
    
    let totalDeaths: Int64
    let totalCases: Int64
    let totalRecovered: Int64
    
    let todayCases: Int64
    let todayDeaths: Int64
}

let blankGlobalData = GlobalData(newDeaths: -1, newCases: -1, totalDeaths: -1, totalCases: -1, totalCritical: -1 , totalRecovered: -1)
let blankCountryData = CountryData(countryName: "", countryCode: "", population: -1, latitude: -1, longtitude: -1, fatalityRate: -1, recoveryRate: -1, totalDeaths: -1, totalCases: -1, totalRecovered: -1, todayCases: -1, todayDeaths: -1)
