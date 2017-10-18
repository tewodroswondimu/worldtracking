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
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        // A node is a position in space with no shape, size or color
        let node = SCNNode();
        
        // Create a box shape with a size of 0.1 and is not rounded
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0);
        
        // Give the box a color
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        // 3d vector of where it the node should be
        node.position = SCNVector3(-0.3,-0.2,0.5);
        
        // Add the node to the root node
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

