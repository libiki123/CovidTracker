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
import CoreData

class CovidDataRequest: ObservableObject{
    @Published var globalData: GlobalData = blankGlobalData
    @Published var countriesData: [CountryData] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        resetCoreData()
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
                
                let gbData = GlobalDataModel(context: self.context)
                gbData.newCases = self.globalData.newCases
                gbData.newDeaths = self.globalData.newDeaths
                gbData.totalCases = self.globalData.totalCases
                gbData.totalDeaths = self.globalData.totalDeaths
                gbData.totalRecovered = self.globalData.totalRecovered
                gbData.totalCritical = self.globalData.totalCritical
                
                try? self.context.save()
                
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
                        countryName: countryJson["name"].stringValue,
                        countryCode: countryJson["code"].stringValue,
                        population: Int64(countryJson["population"].intValue),
                        
                        latitude: cordinateJson["latitude"].doubleValue,
                        longtitude: cordinateJson["longitude"].doubleValue,
                        
                        fatalityRate: calculatedJson["death_rate"].doubleValue,
                        recoveryRate: calculatedJson["recovery_rate"].doubleValue,
                        
                        totalDeaths: Int64(latestDataJson["deaths"].intValue),
                        totalCases: Int64(latestDataJson["confirmed"].intValue),
                        totalRecovered: Int64(latestDataJson["recovered"].intValue),
                        
                        todayCases: Int64(todayDataJson["deaths"].intValue),
                        todayDeaths: Int64(todayDataJson["deaths"].intValue))
                    
                    let ctData = CountryDataModel(context: self.context)
                    ctData.countryName = countryData.countryName
                    ctData.countryCode = countryData.countryCode
                    ctData.population = countryData.population
                    ctData.latitude = countryData.latitude
                    ctData.longtitude = countryData.longtitude
                    ctData.fatalityRate = countryData.fatalityRate
                    ctData.recoveryRate = countryData.recoveryRate
                    ctData.totalDeaths = countryData.totalDeaths
                    ctData.totalCases = countryData.totalCases
                    ctData.totalRecovered = countryData.totalRecovered
                    ctData.todayCases = countryData.todayCases
                    ctData.todayDeaths = countryData.todayDeaths
                    
                    try? self.context.save()

                    tempCountriesData.append(countryData)
                }
                self.countriesData = tempCountriesData.sorted(by: {$0.totalCases > $1.totalCases})
            } else {
                // error handle
            }
        }
    }
    
    func resetCoreData(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GlobalDataModel")
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "CountryDataModel")

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)

        do {
            try context.execute(batchDeleteRequest)
            try context.execute(batchDeleteRequest2)

        } catch {
            // Error Handling
        }
    }
}
    

