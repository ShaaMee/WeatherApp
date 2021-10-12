import Foundation

class DetailWeatherViewModel {
  
  let imgUrlPrefix = "http://openweathermap.org/img/wn/"
  let imgUrlPostfix = "@4x.png"
  
  var currentWeather = WeatherData()
  
  var weatherIconData: Data? {
    let iconString = imgUrlPrefix + currentWeather.icon + imgUrlPostfix
    guard let imageURL = URL(string: iconString),
          let imageData = try? Data(contentsOf: imageURL) else { return nil }
    return imageData
  }
  
  var titleText: String {
    return "Подробнее о погоде на \(currentWeather.date)"
  }
  
}
