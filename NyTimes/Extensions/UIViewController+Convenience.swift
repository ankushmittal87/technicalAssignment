//
//  UIViewController+Convenience.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import UIKit

extension UIViewController {
    public func hideBackButtonText() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
}
}
