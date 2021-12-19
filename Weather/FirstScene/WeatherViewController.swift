import UIKit

protocol WeatherDisplayLogic: AnyObject {
    func displayData(_ viewModel: WeatherModel.FetchData.ViewModel)
}

final class WeatherViewController: UIViewController {
    var interactor: WeatherBusinessLogic?
    var router: WeatherRoutingLogic?
    
    private var currentLocationLabel: UILabel!
    private var currentTemperatureLabel: UILabel!
    private var currentDescriptionLabel: UILabel!
    private var hourCollectionView: UICollectionView!
    private var weekTableView: UITableView!
    var arrayForecast = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor?.fetchData(WeatherModel.FetchData.Request())
    }
    private func configureView() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        let topColor = UIColor(red: 197/255, green: 219/255, blue: 252/255, alpha: 1.0)
        let bottomColor = UIColor(red: 214/255, green: 180/255, blue: 201/255, alpha: 1)
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
    private func configureCurrentLocationLabel() {
        currentLocationLabel = UILabel()
                currentLocationLabel.translatesAutoresizingMaskIntoConstraints = false
                currentLocationLabel.font = currentLocationLabel.font.withSize(36)
                currentLocationLabel.textColor = .white
                currentLocationLabel.text = "City"
                view.addSubview(currentLocationLabel)
                NSLayoutConstraint.activate([
                    currentLocationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    currentLocationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
                ])
    }
    private func configureCurrentTemperatureLabel() {
                currentTemperatureLabel = UILabel()
                currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
                currentTemperatureLabel.font = currentTemperatureLabel.font.withSize(56)
                currentTemperatureLabel.textColor = .white
                currentTemperatureLabel.text = "5°C"
                view.addSubview(currentTemperatureLabel)
                NSLayoutConstraint.activate([
                    currentTemperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    currentTemperatureLabel.topAnchor.constraint(equalTo: currentLocationLabel.bottomAnchor, constant: 4)
                ])
    }
    private func configureCurrentDescriptionLabel() {
                currentDescriptionLabel = UILabel()
                currentDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
                currentDescriptionLabel.font = currentDescriptionLabel.font.withSize(20)
                currentDescriptionLabel.textColor = .white
                currentDescriptionLabel.text = "Cloudy"
                view.addSubview(currentDescriptionLabel)
                NSLayoutConstraint.activate([
                    currentDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    currentDescriptionLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 8)
                ])
    }
    private func configureHourCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.itemSize = CGSize(width: 80, height: 130)
        layout.scrollDirection = .horizontal
        
        hourCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        hourCollectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
        hourCollectionView.backgroundColor = .clear
        
        hourCollectionView.dataSource = self
        hourCollectionView.delegate = self
        
        view.addSubview(hourCollectionView)
        hourCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hourCollectionView.topAnchor.constraint(equalTo: currentDescriptionLabel.bottomAnchor, constant: 20),
            hourCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hourCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            hourCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        hourCollectionView.layer.borderWidth = 1
        hourCollectionView.layer.cornerRadius = 5
        hourCollectionView.layer.borderColor = UIColor.white.cgColor
    }
    private func configureWeekTableView() {
        weekTableView = UITableView()
        weekTableView.layer.cornerRadius = 10
        weekTableView.register(WeekTableViewCell.self, forCellReuseIdentifier: WeekTableViewCell.identifier)
        weekTableView.delegate = self
        weekTableView.dataSource = self
        view.addSubview(weekTableView)
        
        weekTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekTableView.topAnchor.constraint(equalTo: hourCollectionView.bottomAnchor, constant: 10),
            weekTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            weekTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weekTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    private func configureUI() {
        configureView()
        configureCurrentLocationLabel()
        configureCurrentTemperatureLabel()
        configureCurrentDescriptionLabel()
        configureHourCollectionView()
        configureWeekTableView()
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrayForecast.count > 8 {
            return 8    // cells for forecasting for a day by 3 hours
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourCell = hourCollectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier, for: indexPath) as! HourCollectionViewCell
        hourCell.update(by: arrayForecast[indexPath.item])
        return hourCell
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayForecast.count > 0 {
            return arrayForecast.count - 8
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weekCell = weekTableView.dequeueReusableCell(withIdentifier: WeekTableViewCell.identifier, for: indexPath) as! WeekTableViewCell
        weekCell.update(by: arrayForecast[indexPath.item + 8])
        return weekCell
    }
}

// MARK: - WeatherDisplayLogic
extension WeatherViewController: WeatherDisplayLogic {
    func displayData(_ viewModel: WeatherModel.FetchData.ViewModel) {
        DispatchQueue.main.async {
            guard let listForecast = viewModel.listForecast else {return}
            self.arrayForecast = listForecast
            
            self.hourCollectionView.reloadData()
            self.weekTableView.reloadData()
            
            self.currentLocationLabel.text = listForecast[0].city
            self.currentTemperatureLabel.text = listForecast[0].temp
            self.currentDescriptionLabel.text = listForecast[0].description
        }
    }
}
