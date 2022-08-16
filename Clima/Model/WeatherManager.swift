//
//  WeatherManager.swift
//  Clima
//
//  Created by Mohanad on 8/15/22.
//

import Foundation

// MARK: - Delegate Protocol

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ watherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

// MARK: - WeatherManager Class

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d5602b6c59dfd7b0a26336d2378a6cf5&units=metric"
    
    var delegate: WeatherManagerDelegate?
    func fetchWeather (_ cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // Creat a URL
        if let url = URL(string: urlString) {
            // Creat a URL Sesstion
            let session = URLSession(configuration: .default)
            // Give the session a task
            let task = session.dataTask(with: url) { data, respone, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(cityName: name, conditionID: id, tempereture: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}