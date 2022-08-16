//
//  WeatherModel.swift
//  Clima
//
//  Created by Mohanad on 8/16/22.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let conditionID: Int
    let tempereture: Double
    
    var temperetureString: String {
        return String(format: "%.1f", tempereture)
    }
    
    var conditionName: String {
        switch conditionID {
                case 200...232:
                    return "cloud.bolt.fill"
                case 300...321:
                    return "cloud.drizzle.fill"
                case 500...531:
                    return "cloud.rain.fill"
                case 600...622:
                    return "cloud.snow.fill"
                case 701...781:
                    return "cloud.fog.fill"
                case 800:
                    return "sun.max.fill"
                case 801...804:
                    return "cloud.bolt.fill"
                default:
                    return "cloud"
                }
    }
}
