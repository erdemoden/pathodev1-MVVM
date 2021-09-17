

import Foundation
import UIKit
class AppCoordinator : Coordinator{
    var ChildCoordinators: [Coordinator] = []
    let Window : UIWindow
    init(Window:UIWindow) {
        self.Window = Window
    }
    var NavigationController: UINavigationController?
    
    func Start() {
        let NavigationController = UINavigationController()
        let MainCoordinator = MainCoordinator(NavigationController: NavigationController);
        ChildCoordinators.append(MainCoordinator)
        MainCoordinator.Start();
        Window.rootViewController = NavigationController
        Window.makeKeyAndVisible()
    }
    
}
