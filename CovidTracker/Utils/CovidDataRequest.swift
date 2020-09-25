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

class CovidDataRequest: ObservableObject{
    @Published var globalData: GlobalData = blankGlobalData
    @Published var countriesData: [CountryData] = []
    
    init() {
        getGlobalData()
        getCountriesData()
    }
    
    func getGlobalData(){
        let headers: HTTPHeaders = [
            "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
            "x-rapidapi-key": "2506c7ef8fmsh6526180617bf5ebp1546c2jsn0bf043a18a8c"
        ]
        
        AF.request("https://coronavirus-monitor.p.rapidapi.com/coronavirus/worldstat.php", headers: headers).responseJSON { response in
            let result = response.data
            
            if result != nil{
                let globalDataJson = JSON(result!)
                
                self.globalData =  GlobalData(
                    newDeaths: globalDataJson["new_deaths"].stringValue.formarString(),
                    newCases: globalDataJson["new_cases"].stringValue.formarString(),
                    totalDeaths: globalDataJson["total_deaths"].stringValue.formarString(),
                    totalCases: globalDataJson["total_cases"].stringValue.formarString(),
                    totalCritical: globalDataJson["serious_critical"].stringValue.formarString(),
                    totalRecovered: globalDataJson["total_recovered"].stringValue.formarString())
            } else {
                // error handle
            }
            //print(String(format: "%.2f", self.globalData.fatalityRate))
        }
    }
    
    func getCountriesData(){
        AF.request("https://corona-api.com/countries").responseJSON { response in
            let result = response.data

            if result != nil{
                let json = JSON(result!)
                let countriesDataJson = JSON(json["data"])
                
                var tempCountriesData: [CountryData] = []
                
                for (_, countryJson):(String, JSON) in countriesDataJson {
                    let cordinateJson = JSON(countryJson["coordinates"])
                    let latestDataJson = JSON(countryJson["latest_data"])
                    let calculatedJson = JSON(latestDataJson["calculated"])
                    let todayDataJson = JSON(countryJson["today"])

                    let countryData = CountryData(
                        country: countryJson["name"].stringValue,
                        countryCode: countryJson["code"].stringValue,
                        population: Int64(countryJson["population"].intValue),
                        
                        latitude: Float64(cordinateJson["latitude"].floatValue),
                        longtitude: Float64(cordinateJson["longitude"].floatValue),
                        
                        fatalityRate: Float64(calculatedJson["death_rate"].floatValue),
                        recoveryRate: Float64(calculatedJson["recovery_rate"].floatValue),
                        
                        totalDeaths: Int64(latestDataJson["deaths"].intValue),
                        totalConfirmed: Int64(latestDataJson["confirmed"].intValue),
                        totalRecovered: Int64(latestDataJson["recovered"].intValue),
                        
                        todayConfirmed: Int64(todayDataJson["deaths"].intValue),
                        todayDeaths: Int64(todayDataJson["deaths"].intValue))

//                        date: country["Date"].toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")!
                    tempCountriesData.append(countryData)
                }
                self.countriesData = tempCountriesData.sorted(by: {$0.totalConfirmed > $1.totalConfirmed})
            } else {
                // error handle
            }
        }
    }
    
}
    

