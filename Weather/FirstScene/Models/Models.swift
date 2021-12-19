import Foundation

struct APIResult: Codable {
    let list: [List]?
    let city: City?
}
struct List: Codable {
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
}

struct Main: Codable {
    let temp: Double?
}

struct Weather: Codable {
    let description: String?
    let icon: String?
    let main: String?
}

struct City: Codable {
    let name: String?
}

struct Forecast {
    let day: String
    let hour: String
    let temp: String
    let icon: String
    let description: String
    let city: String
}
