//
//  Weather.swift
//  MVC
//
//  Created by user on 19.05.2021.
//

import Foundation

struct DailyWeather: Decodable{
  
  var daily: [DailyWeatherData]?
}

struct DailyWeatherData: Decodable{
  
  var dt: Int?
  var temp: DailyTemp?
  var feelsLike: FeelsLikeTemp?
  var pressure: Int?
  var humidity: Int?
  var windSpeed: Double?
  var weather: [DailyWeatherDescription]?
}

struct DailyTemp: Decodable{
  
  var day: Double?
}

struct FeelsLikeTemp: Decodable{
  var day: Double?
}

struct DailyWeatherDescription: Decodable{
  
  var description: String?
  var icon: String?
}
