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
    let floorNodeName = "FloorNode"

    override func viewDidLoad() {
        super.viewDidLoad()
        //enabling debug options
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        
        //start the AR session
        config.planeDetection = .horizontal
        sceneView.session.run(config)
        
        sceneView.delegate = self
        addTapGesture()
    }

    func addVirtualObject() {
        //adds a blue capsule object in view
        capsuleNode.position = SCNVector3(0.1, 0.1, -0.1)
        capsuleNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue //1
        capsuleNode.eulerAngles = SCNVector3(0,0,Double.pi/2) //2
        sceneView.scene.rootNode.addChildNode(capsuleNode)
    }
    
    //define "tapped" to get location of where user taps the screen
    @objc func tapped(sender: UITapGestureRecognizer){
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        
        let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty{
            print("Touched on the plane")
        }
        else{
            print("Not a plane")
        }
    }
    
    func addTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        tap.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tap)
    }
    

}
//create an extension of the view controller
extension AugmentedRealityViewController:ARSCNViewDelegate{
    
    func createFloorNode(anchor:ARPlaneAnchor) ->SCNNode{
        let floorNode = SCNNode(geometry: SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z)))
        floorNode.position=SCNVector3(anchor.center.x,0,anchor.center.z)
        floorNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "wooden floor tiles")
        floorNode.geometry?.firstMaterial?.isDoubleSided = true
        floorNode.eulerAngles = SCNVector3(Double.pi/2,0,0)
        floorNode.name = floorNodeName
        return floorNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        let planeNode = createFloorNode(anchor: planeAnchor)
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        node.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
    }
        let planeNode = createFloorNode(anchor: planeAnchor)
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let _ = anchor as? ARPlaneAnchor else {return}
        node.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
    }
}
