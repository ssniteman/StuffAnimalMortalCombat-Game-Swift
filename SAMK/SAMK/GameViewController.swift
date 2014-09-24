//
//  GameViewController.swift
//  SAMK
//
//  Created by Shane Sniteman on 9/22/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

import UIKit
import SpriteKit
import MultipeerConnectivity

// save the game in its state

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, MCBrowserViewControllerDelegate {
    
    // created variables
    
    let statusVC = StatusViewController()
    let controlsVC = ControlsViewController()
    let playerConnect = PlayerConnect()
    
    var findFriendsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            
            // SCALLING PROPORTIONALLY TO SCREEN SIZE
            
            scene.size = UIScreen.mainScreen().bounds.size
            
            // Configure the view.
            let skView = self.view as SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
            controlsVC.scene = scene
            playerConnect.scene = scene
        }
        
        
        // our coding !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        
        playerConnect.browser.delegate = self
        
        findFriendsButton = UIButton (frame: self.view.frame)
//        findFriendsButton.layer.cornerRadius = 50
        findFriendsButton.setTitle("Find Friends", forState: .Normal)
        findFriendsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        findFriendsButton.backgroundColor = (UIColor.whiteColor())
        findFriendsButton.center = self.view.center
        findFriendsButton.addTarget(self, action: Selector("findFriends"), forControlEvents: .TouchUpInside)
        
        
        controlsVC.playerConnect = playerConnect
        self.view.addSubview(statusVC.view)
        self.view.addSubview(controlsVC.view)
        
//        self.view.addSubview(findFriendsButton)

        
    }
    
    func findFriends() {
        
        self.presentViewController(playerConnect.browser, animated: true, completion: nil)

    }
    
    func startGame() {
        
        
    }
    
    func browserViewControllerDidFinish(
        browserViewController: MCBrowserViewController!)  {
            // Called when the browser view controller is dismissed (ie the Done
            // button was tapped)
            
            findFriendsButton.removeFromSuperview()
            
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(
        browserViewController: MCBrowserViewController!)  {
            // Called when the browser view controller is cancelled
            
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
