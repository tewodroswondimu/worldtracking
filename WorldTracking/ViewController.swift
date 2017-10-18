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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

