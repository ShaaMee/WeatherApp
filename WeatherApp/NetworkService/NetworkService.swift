//
//  NetworkService.swift
//  MVC
//
//  Created by user on 19.05.2021.
//

import Foundation
import Alamofire

class NetworkService {
  
  static let shared = NetworkService()
  
  func fetchWeatherData(url: URL, completion: @escaping(Any) -> () ) {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    AF.request(url).validate().responseJSON { response in
      
      guard let data = response.data else {
        print("no data")
        return
      }
      
        do {
          let json = try decoder.decode(DailyWeather.self, from: data)
          DispatchQueue.main.async {
            completion(json)
          }
        } catch { print(error.localizedDescription) }
      
    }
    
  }
}
