import Foundation
import UIKit

protocol WeatherRoutingLogic {
    
}

final class WeatherRouter {
    private weak var viewController: UIViewController?
    
    init( viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension WeatherRouter: WeatherRoutingLogic {
    
}
