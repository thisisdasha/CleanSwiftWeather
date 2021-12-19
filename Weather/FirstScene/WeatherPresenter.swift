import Foundation

protocol WeatherPresentationLogic: AnyObject {
    func presentData(_ response: WeatherModel.FetchData.Response)
}

final class WeatherPresenter {
    private weak var viewController: WeatherDisplayLogic?
    
    init(viewController: WeatherDisplayLogic) {
        self.viewController = viewController
    }
}

extension WeatherPresenter: WeatherPresentationLogic {
    func presentData(_ response: WeatherModel.FetchData.Response) {
        let list = response.listForecast
        viewController?.displayData(WeatherModel.FetchData.ViewModel(listForecast: list))
    }
}
