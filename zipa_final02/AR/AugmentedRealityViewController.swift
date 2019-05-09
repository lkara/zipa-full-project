//
//  AugmentedRealityViewController.swift
//  zipa_final02
//
//  Created by Lydia Kara on 24/04/2019.
//  Copyright © 2019 Lydia Kara. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class AugmentedRealityViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    
    var detectedPlanes: [String : SCNNode] = [:]
    
    var caseTemp = "shirt"
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var restartExperience: UIButton!
    
    enum ObjectPlacementMode {
        case shirt, dress, trouser
    }
    var objectMode: ObjectPlacementMode = .shirt
    
    var selectedNode: SCNNode?
    var placedNodes = [SCNNode]()
    var planeNodes = [SCNNode]()
    
    var lastObjectPlacedPoint: CGPoint?
    let config = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = "Initializing..."
        
        // Create a new scene
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        // Gestures
        let tapGesure = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGesure)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //will determine the configurations of the scene session
        config.planeDetection = .horizontal
        sceneView.session.run(config)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: sceneView)
        guard let hitTestResult = sceneView.hitTest(location, types: .existingPlane).first else { return }
        let position = SCNVector3Make(hitTestResult.worldTransform.columns.3.x,
                                      hitTestResult.worldTransform.columns.3.y,
                                      hitTestResult.worldTransform.columns.3.z)
       
        print("location: \(location)")
        if (objectMode == .shirt){
            print("shirt selected")
            addShirtModel(position: position)
        } else if (objectMode == .dress){
            print("dress selected")
            addDressModel(position: position)
        } else {
            print("trouser selected")
            addTrouserModel(position: position)
        }
        
        
    }
    
    @objc func scaleObject(gesture: UIPinchGestureRecognizer) {
        
        guard let nodeToScale = selectedNode else { return }
        if gesture.state == .changed {
            
            let pinchScaleX: CGFloat = gesture.scale * CGFloat((nodeToScale.scale.x))
            let pinchScaleY: CGFloat = gesture.scale * CGFloat((nodeToScale.scale.y))
            let pinchScaleZ: CGFloat = gesture.scale * CGFloat((nodeToScale.scale.z))
            nodeToScale.scale = SCNVector3Make(Float(pinchScaleX), Float(pinchScaleY), Float(pinchScaleZ))
            gesture.scale = 1
            
        }
        if gesture.state == .ended { }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOptions" {
            let garmentViewController = segue.destination as! GarmentSelectionViewController
            garmentViewController.delegate = self
        }
    }
    
    //3D asset - shirt
    func addShirtModel(position: SCNVector3) {
        // 1
        guard let ShirtScene = SCNScene(named: "garments.scnassets/checkShirt/checkShirt.dae") else {
            fatalError("Unable to find shirt")
        }
        // 2
        guard let baseNode = ShirtScene.rootNode.childNode(withName: "baseNode", recursively: true) else {
            fatalError("Unable to find base node - shirt")
        }
        // 3
        baseNode.position = position
        baseNode.scale = SCNVector3Make(0.05, 0.05, 0.05)
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    //3D asset - dress
    func addDressModel(position: SCNVector3) {
        // 1
        guard let DressScene = SCNScene(named: "garments.scnassets/Dress/Dress.scn") else {
            fatalError("Unable to find statue")
        }
        // 2
        guard let baseNode = DressScene.rootNode.childNode(withName: "baseNode", recursively: true) else {
            fatalError("Unable to find base node")
        }
        // 3
        baseNode.position = position
        baseNode.scale = SCNVector3Make(0.0005, 0.0005, 0.0005)
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    //3D asset - trouser
    func addTrouserModel(position: SCNVector3) {
        // 1
        guard let TrouserScene = SCNScene(named: "garments.scnassets/Jeans/Jeans.scn") else {
            fatalError("Unable to find statue")
        }
        // 2
        guard let baseNode = TrouserScene.rootNode.childNode(withName: "baseNode", recursively: true) else {
            fatalError("Unable to find base node")
        }
        // 3
        baseNode.position = position
        baseNode.scale = SCNVector3Make(0.0005, 0.0005, 0.0005)
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    
    @IBAction func changeObjectMode(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            objectMode = .shirt
        case 1:
            objectMode = .dress
        case 2:
            objectMode = .trouser
        default:
            break
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event:
        UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let node = selectedNode, let touch =
            touches.first else { return }
        
        switch objectMode {
        case .shirt:
            addNodeInFront(node)
        case .dress:
            break
        case .trouser:
            break
        }
    }
    
    func addNodeInFront(_ node: SCNNode) {
        guard let currentFrame = sceneView.session.currentFrame
            else { return }
        // Set transform of node to be 20cm in front of camera
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.2
        node.simdTransform =
            matrix_multiply(currentFrame.camera.transform,
                            translation)
        
        addNodeToSceneRoot(node)
    }
    
    func addNodeToSceneRoot(_ node: SCNNode){
        let cloneNode = node.clone()
        sceneView.scene.rootNode.addChildNode(cloneNode)
        placedNodes.append(cloneNode)
    }
    
    func addNode(_ node: SCNNode, toPlaneUsingPoint point:
        CGPoint) {
        let results = sceneView.hitTest(point, types:
            [.existingPlaneUsingExtent])
        
        if let match = results.first {
            let t = match.worldTransform
            node.position = SCNVector3(x: t.columns.3.x, y:
                t.columns.3.y, z: t.columns.3.z)
            
            addNodeToSceneRoot(node)
            lastObjectPlacedPoint = point
        }
    }

    @IBOutlet weak var togglePlaneButton: UIButton!
    @IBAction func hide_showButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        

        if let image = UIImage(named: "addPressed.png") {
            togglePlaneButton.setImage(image, for: .normal)
        }


            
        showPlaneOverlay = !showPlaneOverlay
        
    }
    var showPlaneOverlay = false {
        didSet {
            for node in planeNodes {
                node.isHidden = !showPlaneOverlay
            }
        }
    }
   
    func nodeAdded(_ node: SCNNode, for anchor: ARPlaneAnchor) {
        let floor = createFloor(planeAnchor: anchor)
        floor.isHidden = !showPlaneOverlay
        
        node.addChildNode(floor)
        planeNodes.append(floor)
    }

    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    if let imageAnchor = anchor as? ARImageAnchor {
            nodeAdded(node, for: imageAnchor)
        } else if let planeAnchor = anchor as? ARPlaneAnchor {
            nodeAdded(node, for: planeAnchor)
        }
        
    }
    
    func createFloor(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let node = SCNNode()
        let geometry = SCNPlane(width:
            CGFloat(planeAnchor.extent.x), height:
            CGFloat(planeAnchor.extent.z))
        
        node.geometry = geometry
        node.eulerAngles.x = -Float.pi / 2
        node.opacity = 0.25
        return node
    }
    
    func reloadConfiguration() {
        config.planeDetection = .horizontal
        config.detectionImages = (objectMode == .trouser) ?
            ARReferenceImage.referenceImages(inGroupNamed:
                "AR Resources", bundle: nil) : nil
        sceneView.session.run(config)
    }
   
    
    func nodeAdded(_ node: SCNNode, for anchor: ARImageAnchor) {
        if let selectedNode = selectedNode {
            addNode(selectedNode, toImageUsingParentNode: node)
        }
    }
    
    func addNode(_ node: SCNNode, toImageUsingParentNode parentNode:
        SCNNode) {
        let cloneNode = node.clone()
        parentNode.addChildNode(cloneNode)
        placedNodes.append(cloneNode)
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        // 2
        guard let planeNode = detectedPlanes[planeAnchor.identifier.uuidString] else { return }
        let planeGeometry = planeNode.geometry as! SCNPlane
        planeGeometry.width = CGFloat(planeAnchor.extent.x)
        planeGeometry.height = CGFloat(planeAnchor.extent.z)
        planeNode.position = SCNVector3Make(planeAnchor.center.x,
                                            planeAnchor.center.y,
                                            planeAnchor.center.z)
    }


}























//create an extension of the view controller
extension AugmentedRealityViewController: GarmentSelectionViewControllerDelegate {
    func objectSelected(node: SCNNode) {
        dismiss(animated: true, completion: nil)
        selectedNode = node
        print(node)
    }
    
    func resetScene() {
        dismiss(animated: true, completion: nil)
    }
    


    
}













extension UIViewController {
    
    func transition(to child: UIViewController, completion: ((Bool) -> Void)? = nil) {
        let duration = 0.3
        
        let current = children.last
        addChild(child)
        
        let newView = child.view!
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newView.frame = view.bounds
        
        if let existing = current {
            existing.willMove(toParent: nil)
            
            transition(from: existing, to: child, duration: duration, options: [.transitionCrossDissolve], animations: { }, completion: { done in
                existing.removeFromParent()
                child.didMove(toParent: self)
                completion?(done)
            })
            
        } else {
            view.addSubview(newView)
            
            UIView.animate(withDuration: duration, delay: 0, options: [.transitionCrossDissolve], animations: { }, completion: { done in
                child.didMove(toParent: self)
                completion?(done)
            })
        }
    }
    
}

