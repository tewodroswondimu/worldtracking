//
//  ViewController.swift
//  WorldTracking
//
//  Created by Tewodros Wondimu on 10/18/17.
//  Copyright © 2017 Tewodros Wondimu. All rights reserved.
//

import UIKit
import ARKit // Allows you to use the ARKit Framework

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    // Used to track position and orientation of your phone
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Debug options allows us
        // Show feature points shows the points in your view
        // Show world origin shows where the origin of the world is
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin];
        
        // Make the sceneview run the configurations
        self.sceneView.session.run(configuration)
        
        // Lets scene kit automatically add lighting (omnidirectional)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        // Call the restart session metohd to restart the world origin
        self.restartSession();
    }
    
    func restartSession() {
        // Stops the device keeping track of your device and orientation
        self.sceneView.session.pause();
        
        // enumerate through all the child nodes and remove them
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode();
        }
        
        // reset the original configuration and resets tracking creating a new one
        // an anchor is information about the location and orientation of an object
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors]);
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        // A node is a position in space with no shape, size or color
        let node = SCNNode();
        
        // Create a box shape with a size of 0.1 and is not rounded
        // if we give the chamferRadius a value we get a rounder looking box
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03);
        
        // changes the specular (light reflected off a surface) response to lighting to white
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange;
        
        // Give the box a color
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        // get a random num x, y and z between -0.3 and 0.3
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3);
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3);
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3);
        
        // 3d vector of where it the node should be
        node.position = SCNVector3(x, y, z);
        
        // Add the node to the root node
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    // generates a random number given a minimum and maximum value
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

