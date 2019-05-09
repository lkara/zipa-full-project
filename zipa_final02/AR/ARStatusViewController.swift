//
//  ARStatusViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 07/05/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit

class ARStatusViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = statusUpdate {
            messageLabel.text = name
        }

        // Do any additional setup after loading the view.
    }
    enum MessageType {
        case trackingStateEscalation
        case planeEstimation
        case contentPlacement
        case focusSquare
        
        static var all: [MessageType] = [
            .trackingStateEscalation,
            .planeEstimation,
            .contentPlacement,
            .focusSquare
        ]
    }
    
    @IBOutlet weak var messagePanel: UIVisualEffectView!
    
    @IBOutlet weak var messageLabel: UILabel!
    var statusUpdate: String?
    
    
    @IBOutlet weak var restartExperience: UIButton!
    

}
