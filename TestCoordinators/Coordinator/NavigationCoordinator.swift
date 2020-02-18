//
//  Created by Andrew Podkovyrin
//  Copyright © 2020 Andrew Podkovyrin. All rights reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://opensource.org/licenses/MIT
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

class NavigationCoordinator: NSObject, Coordinating {
    var viewController: UIViewController { navigationController }

    private let navigationController: UINavigationController
    private var childCoordinators = [UIViewController: Coordinating]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
    }
}

extension NavigationCoordinator {
    func showChild(_ coordinator: Coordinating) {
        let controller = coordinator.viewController
        childCoordinators[controller] = coordinator
        let animated = !navigationController.viewControllers.isEmpty
        navigationController.pushViewController(controller, animated: animated)
    }

    func hideChild(_ coordinator: Coordinating) {
        let viewControllers = navigationController.viewControllers
        let count = viewControllers.count
        if count < 2 {
            debugPrint("Can't hide last coordinator")
            return
        }

        let controller = coordinator.viewController
        guard let index = viewControllers.firstIndex(of: controller) else {
            debugPrint("Trying to hide child controller which is not in the current hierarchy")
            return
        }

        let newViewControllers = Array(viewControllers.dropLast(count - index))
        navigationController.setViewControllers(newViewControllers, animated: true)
    }
}

extension NavigationCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        var newChildCoordinators = [UIViewController: Coordinating]()
        for viewController in navigationController.viewControllers {
            newChildCoordinators[viewController] = childCoordinators[viewController]
        }
        childCoordinators = newChildCoordinators
    }
}
