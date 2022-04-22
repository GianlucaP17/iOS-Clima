//
//  WeatherData.swift
//  Clima
//
//  Created by gianluca posca on 08/06/21.
//  Copyright © 2021 Gianluca Po. All rights reserved.
//

import UIKit

struct WeatherData: Decodable  {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
