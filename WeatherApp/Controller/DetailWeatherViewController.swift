import UIKit

class DetailWeatherViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var feelsLikeLabel: UILabel!
  @IBOutlet weak var pressureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  
  var viewModel = DetailWeatherViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let weatherIconData = viewModel.weatherIconData {
      weatherIcon.image = UIImage(data: weatherIconData)
    }
    
    tempLabel.text = viewModel.currentWeather.temp
    descriptionLabel.text = viewModel.currentWeather.description
    feelsLikeLabel.text = viewModel.currentWeather.feelsLike
    pressureLabel.text = viewModel.currentWeather.pressure
    humidityLabel.text = viewModel.currentWeather.humidity
    windSpeedLabel.text = viewModel.currentWeather.windSpeed
    titleLabel.text = viewModel.titleText
  }
  

  @IBAction func backButton(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}
