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

final class AppCoordinator: NSObject, Coordinating {
    var viewController: UIViewController { rootController }

    let window: UIWindow
    let router: Router

    private let rootController: ViewController
    private var settingsCoordinator: SettingsCoordinator?

    init(window: UIWindow, router: Router) {
        self.window = window
        self.router = router

        rootController = ViewController()
        super.init()
    }

    func start() {
        rootController.delegate = self
        window.rootViewController = rootController
    }
}

extension AppCoordinator: ViewControllerDelegate {
    func mainButtonAction() {
        let settingsCoordinator = SettingsCoordinator(router: router, delegate: self)
        settingsCoordinator.start()
        self.settingsCoordinator = settingsCoordinator
    }

    func secondaryButtonAction() {
        print("Root secondary action is not supported")
    }
}

extension AppCoordinator: SettingsCoordinatorDelegate {
    func settingsCoordinatorDidFinish() {
        settingsCoordinator = nil
    }
}
