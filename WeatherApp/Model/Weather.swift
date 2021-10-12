import Foundation

struct Weather {
  
  var date: Int?
  var temp: Double?
  var feelsLike: Double?
  var pressure: Int?
  var humidity: Int?
  var windSpeed: Double?
  var description: String?
  var icon: String?
}

struct WeatherData {
  
  var date: String = ""
  var temp: String = ""
  var feelsLike: String = ""
  var pressure: String = ""
  var humidity: String = ""
  var windSpeed: String = ""
  var description: String = ""
  var icon: String = ""
}
