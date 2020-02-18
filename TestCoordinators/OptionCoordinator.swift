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

final class OptionCoordinator: Coordinating {
    var viewController: UIViewController { optionController }

    private let optionController: ViewController
    private weak var parentCoordinator: NavigationCoordinator?
    private let data: Int

    init(parentCoordinator: NavigationCoordinator?, data: Int) {
        self.parentCoordinator = parentCoordinator
        self.data = data

        optionController = ViewController()
        optionController.title = "\(data)"
        optionController.delegate = self
    }

    func start() {
        parentCoordinator?.showChild(self)
    }
}

extension OptionCoordinator: ViewControllerDelegate {
    func mainButtonAction() {
        let child = OptionCoordinator(parentCoordinator: parentCoordinator, data: data + 1)
        child.start()
    }

    func secondaryButtonAction() {
        parentCoordinator?.hideChild(self)
    }
}
