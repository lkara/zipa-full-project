//
//  AugmentedRealityViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 24/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit
import ARKit

class AugmentedRealityViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    //will determine the configurations of the scene session
    let config = ARWorldTrackingConfiguration()
    let capsuleNode = SCNNode(geometry: SCNCapsule(capRadius: 0.03, height: 0.1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //enabling debug options
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        
        //start the AR session
        sceneView.session.run(config)
        addVirtualObject()
    }

    func addVirtualObject() {
        capsuleNode.position = SCNVector3(0.1, 0.1, -0.1)
        capsuleNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue //1
        capsuleNode.eulerAngles = SCNVector3(0,0,Double.pi/2) //2
        sceneView.scene.rootNode.addChildNode(capsuleNode)
    }

}
