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
    
    var bg1: BGClass?;
    var bg2: BGClass?;
    var bg3: BGClass?;
    
    var distanceBetweenClouds = CGFloat(240);
    var minX = CGFloat(85);
    var maxX = CGFloat(392);
    
    var cloudsController = CloudsController();


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
        
        bg1 = self.childNode(withName: "BG 1") as? BGClass!;
        bg2 = self.childNode(withName: "BG 2") as? BGClass!;
        bg3 = self.childNode(withName: "BG 3") as? BGClass!;
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: 240, center: center!, minX: minX, maxX: maxX, initialClouds: true);
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        //takes place on every frame
        managePlayer();
        moveCamera();
        manageBackgrounds();
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
    
    func manageBackgrounds () {
        bg1?.moveBackground(camera: mainCamera!);
        bg2?.moveBackground(camera: mainCamera!);
        bg3?.moveBackground(camera: mainCamera!);
    }
}
