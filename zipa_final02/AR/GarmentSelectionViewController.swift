//
//  GarmentSelectionViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 08/05/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit
import SceneKit

protocol GarmentSelectionViewControllerDelegate: class {
    func objectSelected(node: SCNNode)
    func resetScene()
}

class GarmentSelectionViewController: UIViewController, UINavigationControllerDelegate {
    
    private var color: UIColor!
    
    private var nav: UINavigationController?
    
    weak var delegate: GarmentSelectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationController = UINavigationController(rootViewController: scenePicker())
        nav = navigationController
        
        transition(to: navigationController)
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 320, height: 600)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event:
        UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    
    }
    
    private func scenePicker() -> UIViewController {
        let resourceFolder = "garments.scnassets"
        let availableScenes: [String] = {
            let modelsURL = Bundle.main.url(forResource: resourceFolder, withExtension: nil)!
            
            let fileEnumerator = FileManager().enumerator(at: modelsURL, includingPropertiesForKeys: [])!
            
            return fileEnumerator.compactMap { element in
                let url = element as! URL
                
                guard url.pathExtension == "scn" else { return nil }
                
                return url.lastPathComponent
            }
        }()
        
        let options = availableScenes.map { Option(name: $0, option: $0, showsDisclosureIndicator: false) }
        let selector = GarmentTableViewController(options: options)
        selector.optionSelectionCallback = { [unowned self] name in
            let nameWithoutExtension = name.replacingOccurrences(of: ".scn", with: "")
            let scene = SCNScene(named: "\(resourceFolder)/\(nameWithoutExtension)/\(name)")!
            print("garment path: \(resourceFolder)/\(nameWithoutExtension)/\(name), scene path: \(scene)")
            self.delegate?.objectSelected(node: scene.rootNode)
        }
        return selector
    }

}
