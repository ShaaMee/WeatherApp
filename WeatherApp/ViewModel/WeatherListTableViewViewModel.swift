import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import Alamofire

class WeatherListTableViewViewModel {
  
  let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=59.937500&lon=30.308611&exclude=current,minutely,hourly,alerts&units=metric&lang=ru&appid=dc38330af7832da70e101cc8b4c7e914"
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ru_RU")
    formatter.dateFormat = "d MMMM"
    return formatter
  }
    
  var weatherData: BehaviorRelay<[WeatherData]> = BehaviorRelay(value: [])

  var newWeatherData: [Weather]? {
    didSet {
      formatWeatherFrom(data: newWeatherData)
    }
  }
  
  
  func getWeatherData(){
        
    guard let url = URL(string: urlString) else { return }
    
    AF.request(url).validate().responseJSON { [weak self] response in
      
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        var weather = [Weather]()
        
        for dailyWeather in json["daily"].arrayValue {
          var currentWeather = Weather()
          currentWeather.date = dailyWeather["dt"].intValue
          currentWeather.temp = dailyWeather["temp"]["day"].doubleValue
          currentWeather.feelsLike = dailyWeather["feels_like"]["day"].doubleValue
          currentWeather.pressure = dailyWeather["pressure"].intValue
          currentWeather.humidity = dailyWeather["humidity"].intValue
          currentWeather.windSpeed = dailyWeather["wind_speed"].doubleValue
          currentWeather.description = dailyWeather["weather"][0]["description"].stringValue
          currentWeather.icon = dailyWeather["weather"][0]["icon"].stringValue
          weather.append(currentWeather)
        }
        self?.newWeatherData = weather
        
      case .failure:
        return
      }
    }
  }
  
  func formatWeatherFrom(data receivedData: [Weather]?) {
    guard let weatherData = receivedData else { return }
    let data = weatherData.map{ weather -> WeatherData in
      
      var currentWeather = WeatherData()
      var sign = ""
      
      switch weather.temp ?? 0 {
      case 1...: sign = "+"
      case ..<0: sign = "-"
      default: sign = ""
      }
      
      currentWeather.date = "\(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.date ?? 0))))"
      currentWeather.temp = "\(sign)\(String(Int(weather.temp ?? 0))) ºC"
      currentWeather.feelsLike = "Ощущается как: \(sign)\(String(Int(weather.feelsLike ?? 0))) ºC"
      currentWeather.pressure = "Давление: \(weather.pressure ?? 0) кПа"
      currentWeather.humidity = "Влажность: \(weather.humidity ?? 0) %"
      currentWeather.windSpeed = "Скорость ветра: \(weather.windSpeed ?? 0) м/с"
      currentWeather.description = weather.description ?? ""
      currentWeather.icon = weather.icon ?? ""
      return currentWeather
    }
    
    self.weatherData.accept(data)
  }
}
