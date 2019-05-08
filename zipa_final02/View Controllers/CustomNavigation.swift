//
//  CustomNavigation.swift
//  zipa_final02
//
//  Created by Lydia Kara on 08/05/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit

class CustomNavigation: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
}
