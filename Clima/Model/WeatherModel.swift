//
//  WeatherModel.swift
//  Clima
//
//  Created by gianluca posca on 08/06/21.
//  Copyright © 2021 Gianluca Po. All rights reserved.
//

import UIKit
struct WeatherModel {
    
    let conditionID: Int
    let cityName:String
    let temperature:Double
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    //computed prop, sopra sono store prop
    var conditionName:String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }

    }
    
}
