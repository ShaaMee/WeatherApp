import UIKit
import RxCocoa
import RxSwift

class WeatherListTableViewController: UITableViewController {
  
  var viewModel: WeatherListTableViewViewModel?
  let bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = nil
    tableView.delegate = nil
    tableView.rx
      .setDelegate(self)
      .disposed(by: bag)
    
    viewModel = WeatherListTableViewViewModel()
    viewModel?.getWeatherData()
    
    viewModel?.weatherData
      .asObservable()
      .bind(to: tableView.rx.items(cellIdentifier: "weatherListCell", cellType: WeatherListTableViewCell.self)) { index, element, cell in
        cell.dateLabel.text = element.date
        cell.tempLabel.text = element.temp
      }.disposed(by: bag)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    guard let detailsVC = segue.destination as? DetailWeatherViewController else { return }
    guard let indexPath = tableView.indexPathForSelectedRow else { return }
    guard let viewModel = viewModel else { return }
    detailsVC.viewModel.currentWeather = viewModel.weatherData.value[indexPath.row]
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "showDetail", sender: nil)
    self.tableView.deselectRow(at: indexPath, animated: true)
  }
}
