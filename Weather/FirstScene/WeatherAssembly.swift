import Foundation
import UIKit

enum WeatherAssembly {
    static func assembly() -> UIViewController {
        let view = WeatherViewController()
        let presenter = WeatherPresenter(viewController: view)
        let worker = NetworkManager()
        let interactor = WeatherInteractor(presenter: presenter, worker: worker)
        let router = WeatherRouter(viewController: view)
        view.interactor = interactor
        view.router = router
        
        return view
    }
}
