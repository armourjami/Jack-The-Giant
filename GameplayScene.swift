//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Jamie Armour on 4/06/17.
//  Copyright © 2017 Jamie Armour. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var player: Player?
    
    var canMove = false;
    var moveLeft = false;
    
    var center: CGFloat?
    
    var mainCamera: SKCameraNode?

    override func didMove(to view: SKView){
        initializeVariables();
    }
    
    func initializeVariables () {
        
        center = (self.scene?.size.width)! / (self.scene?.size.height)!;
        
        //gets the main Player
        player = self.childNode(withName: "Player") as? Player!;
        
        //inits the Player and animations - obviously
        player?.initialisePlayerAndAnimations();
        
        //gets the Main Camera
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!;
    }
    
    override func update(_ currentTime: TimeInterval) {
        //takes place on every frame
        managePlayer();
        moveCamera();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //like touch start
        for touch in touches {
            let location = touch.location(in: self);
            if location.x > center! {
                moveLeft = false;
                player?.animatePlayer(moveLeft: moveLeft);
            } else {
                moveLeft = true;
                player?.animatePlayer(moveLeft: moveLeft);
            }
        }
        
        canMove = true;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //like touch stop
        canMove = false;
        player?.stopPlayerAnimation();
    }
    
    func managePlayer () {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft);
        }
    }
    
    func moveCamera () {
        //slowly move the camera
        self.mainCamera?.position.y -= 3;
    }
}
