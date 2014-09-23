//
//  PlayerConnect.swift
//  SAMK
//
//  Created by Shane Sniteman on 9/22/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

import UIKit
import MultipeerConnectivity

let kMCSessionMimimumNumberofPeers = 1
let kMCSessionMaximumNumberofPeers = 1

class PlayerConnect: NSObject,
MCSessionDelegate {
    
    var scene: GameScene!

    let serviceType = "stuffedAnimalMK"
    
    var browser : MCBrowserViewController!
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!
    var peerID: MCPeerID!

    
    override init() {
        
        super.init()
        
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        // create the browser viewcontroller with a unique service name
        self.browser = MCBrowserViewController(serviceType:serviceType,
            session:self.session)
        
        self.browser.maximumNumberOfPeers = 1
        
        self.assistant = MCAdvertiserAssistant(serviceType:serviceType,
            discoveryInfo:nil, session:self.session)
        
        // tell the assistant to start advertising our fabulous chat
        self.assistant.start()
    }
    
    func sendPlayerInfo(info: NSDictionary) {
        
        var infoData = NSKeyedArchiver.archivedDataWithRootObject(info)
        
        self.session.sendData(infoData, toPeers: self.session.connectedPeers, withMode: .Reliable, error: nil)
    
    }
 
    func session(session: MCSession!, didReceiveData data: NSData!,
        fromPeer peerID: MCPeerID!)  {
            // Called when a peer sends an NSData to us
            
            // This needs to run on the main queue
            dispatch_async(dispatch_get_main_queue()) {
                
            var info = NSKeyedUnarchiver.unarchiveObjectWithData(data) as NSDictionary
            
                if info["moveLeft"] != nil {
                    
                    self.scene.player2.body.physicsBody?.applyImpulse(CGVectorMake(-40.0, 0.0))
                }
                
                if info["moveRight"] != nil {
                    
                    self.scene.player2.body.physicsBody?.applyImpulse(CGVectorMake(40.0, 0.0))
                }
                
                // take data and move player2
            }
    }
    
    // The following methods do nothing, but the MCSessionDelegate protocol
    // requires that we implement them.
    func session(session: MCSession!,
        didStartReceivingResourceWithName resourceName: String!,
        fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!)  {
            
            // Called when a peer starts sending a file to us
    }
    
    func session(session: MCSession!,
        didFinishReceivingResourceWithName resourceName: String!,
        fromPeer peerID: MCPeerID!,
        atURL localURL: NSURL!, withError error: NSError!)  {
            // Called when a file has finished transferring from another peer
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!,
        withName streamName: String!, fromPeer peerID: MCPeerID!)  {
            // Called when a peer establishes a stream with us
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!,
        didChangeState state: MCSessionState)  {
            // Called when a connected peer changes state (for example, goes offline)
            
            println(peerID.displayName)
            println(state)
            
    }
    
}
