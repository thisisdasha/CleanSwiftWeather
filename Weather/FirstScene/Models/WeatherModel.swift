import Foundation

struct WeatherModel {
    struct FetchData {
        struct Request {}
        struct Response {
            let listForecast: [Forecast]?
        }
        struct ViewModel {
            let listForecast: [Forecast]?
        }
    }
}
