import Foundation

protocol NetworkManagerProtocol {
    func fetchWeatherByCityName(city: String, completion: @escaping (Data?) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    private let apiKey = "9eee8998dafa429e168c2ab0fb88ddd0"
    
    func fetchWeatherByCityName(city: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city.replacingOccurrences(of: " ", with: "+"))&appid=\(apiKey)") else {
            print("url doesn't exist")
            return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            completion(data)
        }.resume()
    }
}
