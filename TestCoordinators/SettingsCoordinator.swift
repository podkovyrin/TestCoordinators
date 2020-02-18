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

protocol SettingsCoordinatorDelegate: AnyObject {
    func settingsCoordinatorDidFinish()
}

final class SettingsCoordinator: NavigationCoordinator {
    private let router: Router
    private weak var delegate: SettingsCoordinatorDelegate?

    init(router: Router, delegate: SettingsCoordinatorDelegate?) {
        self.router = router
        self.delegate = delegate

        let navigationController = UINavigationController()
        super.init(navigationController: navigationController)

        navigationController.presentationController?.delegate = self
    }

    override func start() {
        super.start()

        router.show(viewController)

        let rootChild = OptionCoordinator(parentCoordinator: self, data: 0)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelButtonAction))
        rootChild.viewController.navigationItem.leftBarButtonItem = cancelButton
        rootChild.start()
    }
}

extension SettingsCoordinator {
    @objc
    private func cancelButtonAction() {
        router.hide(viewController)
        delegate?.settingsCoordinatorDidFinish()
    }
}

extension SettingsCoordinator: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.settingsCoordinatorDidFinish()
    }
}
