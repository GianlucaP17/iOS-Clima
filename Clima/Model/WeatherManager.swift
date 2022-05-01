//
//  WeatherManager.swift
//  Clima
//
//  Created by gianluca posca on 08/06/21.
//  Copyright © 2021 Gianluca Po. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather:WeatherModel)
    func didFailWithError(error:Error)
}

class WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=your_id&units=metric"
    
    func fetchWeather(cityName:String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(urlString)
    }
    
    func fetchWeather(lat:String,lon:String) {
        let urlString = "\(weatherURL)&lat=\(lat)&lat=\(lon)"
        self.performRequest(urlString)
    }
    
    func performRequest(_ urlString:String) {
        // 1 creo url
        if let url = URL(string: urlString){
            // 2 create urlSession
            let session = URLSession(configuration: .default)
            // 3 give the session task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //parse JSON
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // 4 start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            //se json diverso > error
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            
            return WeatherModel(conditionID: id, cityName: cityName, temperature: temp)
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil // se fail
        }
        
    }
    
}
