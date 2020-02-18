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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: Coordinating?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        let coordinator = AppCoordinator(window: window, router: self)
        coordinator.start()
        self.coordinator = coordinator

        return true
    }
}

extension AppDelegate: Router {
    func show(_ controller: UIViewController) {
        guard let rootController = window?.rootViewController else {
            preconditionFailure("Root controller is not set")
        }

        rootController.present(controller, animated: true)
    }

    func hide(_ controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
