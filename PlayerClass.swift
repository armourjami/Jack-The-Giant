//
//  PlayerClass.swift
//  Jack The Giant
//
//  Created by Jamie Armour on 4/06/17.
//  Copyright © 2017 Jamie Armour. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let PLAYER: UInt32 = 0;
    static let CLOUD: UInt32 = 1;
    static let DARK_CLOUD_AND_COLLECTABLES: UInt32 = 2;
}

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas();
    private var playerAnimation = [SKTexture]();
    private var animatePlayerAction = SKAction();
    
    func initialisePlayerAndAnimations () {
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas");
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)";
            playerAnimation.append(SKTexture(imageNamed: name));
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false);
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 5));
        self.physicsBody?.affectedByGravity = true;
        self.physicsBody?.allowsRotation = false;
        self.physicsBody?.restitution = 0;
        self.physicsBody?.categoryBitMask = ColliderType.PLAYER;
        self.physicsBody?.collisionBitMask = ColliderType.CLOUD;
        self.physicsBody?.contactTestBitMask = ColliderType.DARK_CLOUD_AND_COLLECTABLES;
        
        
    }
    
    func movePlayer (moveLeft: Bool) {
        if moveLeft {
            self.position.x -= 7;
        } else {
            self.position.x += 7;
        }
    }
    
    func animatePlayer (moveLeft: Bool) {
        if moveLeft {
            self.xScale = -fabs(self.xScale);
        } else {
            self.xScale = fabs(self.xScale);
        }
        
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate");
        
    }
    
    func stopPlayerAnimation () {
        self.removeAction(forKey: "Animate");
        self.texture = SKTexture(imageNamed: "Player 1");
        self.size = (self.texture?.size())!;
    }
}
