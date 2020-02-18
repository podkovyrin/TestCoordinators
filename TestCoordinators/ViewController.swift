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

protocol ViewControllerDelegate: AnyObject {
    func mainButtonAction()
    func secondaryButtonAction()
}

class ViewController: UIViewController {
    weak var delegate: ViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        let button = UIButton(type: .system)
        button.setTitle("Main action", for: .normal)
        button.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)

        let secondaryButton = UIButton(type: .system)
        secondaryButton.setTitle("Secondary action", for: .normal)
        secondaryButton.addTarget(self, action: #selector(secondaryButtonAction), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [button, secondaryButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc
    private func mainButtonAction() {
        delegate?.mainButtonAction()
    }

    @objc
    private func secondaryButtonAction() {
        delegate?.secondaryButtonAction()
    }
}
