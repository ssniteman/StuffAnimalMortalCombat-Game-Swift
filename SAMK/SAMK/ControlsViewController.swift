//
//  ControlsViewController.swift
//  SAMK
//
//  Created by Shane Sniteman on 9/22/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

import UIKit

class ControlsViewController: UIViewController {

    var aButton = UIButton()
    var bButton = UIButton()
    
    var joyStick = UIView()
    var joyStickHandle = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRectMake(0, SCREEN_HEIGHT - 140, SCREEN_WIDTH, 140)
        
        self.view.backgroundColor = UIColor.blueColor()

        // Do any additional setup after loading the view.
        
        let buttonSize: CGFloat = 60.0
        let buttonPadding: CGFloat = 20.0
        
        aButton.frame = CGRectMake(SCREEN_WIDTH - buttonSize * 2.0, self.view.frame.size.height - buttonSize - buttonPadding, buttonSize, buttonSize)
        
        aButton.backgroundColor = UIColor.whiteColor()
        aButton.setTitle("A", forState: .Normal)
        aButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        aButton.layer.cornerRadius = buttonSize / 2.0
        
        self.view.addSubview(aButton)
        
        
        
        bButton.frame = CGRectMake(SCREEN_WIDTH - buttonSize - buttonPadding, self.view.frame.size.height - buttonSize * 2.0, buttonSize, buttonSize)
        
        bButton.backgroundColor = UIColor.whiteColor()
        bButton.setTitle("B", forState: .Normal)
        bButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        bButton.layer.cornerRadius = buttonSize / 2.0
        
        self.view.addSubview(bButton)
        
        renderJoyStick()
        
    }
    
    func renderJoyStick() {
        
        joyStick.frame = CGRectMake(20, 20, 100, 100)
        joyStick.layer.cornerRadius = 50
        joyStick.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(joyStick)
        
        joyStickHandle.frame = CGRectMake(0, 0, 60, 60)
        joyStickHandle.layer.cornerRadius = 30
        joyStickHandle.backgroundColor = UIColor.blackColor()
        joyStickHandle.center = joyStick.center
        
        self.view.addSubview(joyStickHandle)
        
        
    }
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch in touches.allObjects as [UITouch] {
            
            let location = touch.locationInView(self.view)
            
            if CGRectContainsPoint(joyStick.frame, location) {
                
                joyStickHandle.center = location
                
            }
            
        }
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        for touch in touches.allObjects as [UITouch] {
            
            let location = touch.locationInView(self.view)
            
            if CGRectContainsPoint(joyStick.frame, location) {
                
                joyStickHandle.center = location
                
            }
            
        }
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.joyStickHandle.center = self.joyStick.center
            
        })
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
