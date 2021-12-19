import Foundation

protocol WeatherBusinessLogic: AnyObject {
    func fetchData(_ request: WeatherModel.FetchData.Request)
}

protocol WeatherDataStore {
    func getScenarioModel()
}

final class WeatherInteractor {
    
    private let presenter: WeatherPresentationLogic?
    private let worker: NetworkManagerProtocol
    var listArray = [List]()    // api data
    var listForecast = [Forecast]() // viewModel data
    
    init(presenter: WeatherPresentationLogic, worker: NetworkManagerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
}

extension WeatherInteractor: WeatherBusinessLogic {
    func fetchData(_ request: WeatherModel.FetchData.Request) {
        worker.fetchWeatherByCityName(city: "Nizhniy Novgorod") { data in
            guard let data = data else { print("No data"); return }
            do {
                let apiResult = try JSONDecoder().decode(APIResult.self, from: data)
                self.listArray = apiResult.list ?? []
                
                
                for index in 0...self.listArray.count - 1 {
                    let list = self.listArray[index]
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "E "
                    let day = Date(timeIntervalSince1970: TimeInterval(list.dt!))
                    let dayString = dateFormatter.string(from: day)
                    
                    let hourDateFormatter = DateFormatter()
                    hourDateFormatter.dateFormat = "HH"
                    let hour = Date(timeIntervalSince1970: TimeInterval(list.dt!))
                    
                    guard let temp = list.main?.temp else { return }
                    let tempInCelsius = "\(Int(round(temp - 273.15)))°C"
                    guard let icon = list.weather?[0].icon else { return }
                    guard let description = list.weather?[0].main else {return}
                    guard let city = apiResult.city?.name else {return}
                    
                    let forecast = Forecast(day: dayString, hour: hourDateFormatter.string(from: hour), temp: tempInCelsius, icon: icon, description: description, city: city)
                    self.listForecast.append(forecast)
                }
                self.presenter?.presentData(WeatherModel.FetchData.Response(listForecast: self.listForecast))
            } catch let error {
                print("Error serialization json: ", error)
            }

        }
    }
}
