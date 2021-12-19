import UIKit
import Foundation

class NetworkManager {
    
    private let apiKey = "9eee8998dafa429e168c2ab0fb88ddd0"
 
    func fetchWeatherByCityName(city: String) {
        print("IN NetworkManager")
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Нижний%20новгород&appid=9eee8998dafa429e168c2ab0fb88ddd0") else {
            print("url doesn't exist")
            return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("data doesn't exist")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print( error )
            }
        }.resume()
    }
}

var nm = NetworkManager()

