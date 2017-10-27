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
        // node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03);
        
        // Create a capsule with 0.1m radius, 0.3m height, green color and yellow lighting
        // node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        
        // Create a cone with a top of 0.1m, a bottom of 0.3m and height of 0.3m
        // this can be changed to a cone by making the top radius and bottom radius equal
        // node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.3, height: 0.3)
        
        // Create a cylinder with a radius of 0.2m and 0.2m height
        // node.geometry = SCNCylinder(radius: 0.2, height: 0.2);
        
        // Creating a sphere with 0.2m radius
        // node.geometry = SCNSphere(radius: 0.2);
        
        // a tube is similar to a cylinder but has two radius, a inner and outer one
        // node.geometry = SCNTube(innerRadius: 0.1, outerRadius: 0.2, height: 0.3);
        
        // A torus is look like a doughnut with ring radius how wide, pipeRadius how thick
        // the pipe radius should be smaller than the ring radius
        // node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
        
        // a plane is a flat surface with no depth
        // node.geometry = SCNPlane(width: 0.1, height: 0.1)
        
        // A pyramid has a lenghth height and width
        // node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        
        // basier path is create custom path by drawing lines between two or more points
        // to start drawing a line we create a UIBezierPath object and move it to the origin
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Once the pat has been created we can add more lines
        // The paths below allow us to draw a house
        path.addLine(to: CGPoint(x:0, y:0))
        path.addLine(to: CGPoint(x:0, y:0.2))
        path.addLine(to: CGPoint(x:0.2, y: 0.3))
        path.addLine(to: CGPoint(x:0.4, y: 0.2))
        path.addLine(to: CGPoint(x:0.4, y: 0))
        
        // assign to geometry
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
        
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

