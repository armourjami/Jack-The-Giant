//
//  PlayerClass.swift
//  Jack The Giant
//
//  Created by Jamie Armour on 4/06/17.
//  Copyright © 2017 Jamie Armour. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas();
    private var playerAnimation = [SKTexture]();
    private var animatePlayerAction = SKAction();
    
    func initialisePlayerAndAnimations () {
        
        textureAtlas = SKTextureAtlas(named: "Player");
        
        print(textureAtlas.textureNames);
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)";
            playerAnimation.append(textureAtlas.textureNamed(name));
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false);
        
    }
    
    func movePlayer (moveLeft: Bool) {
        if moveLeft {
            self.position.x = self.position.x - 7;
        } else {
            self.position.x = self.position.x + 7;
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
        self.texture = textureAtlas.textureNamed("Player1.png");
        self.size = (self.texture?.size())!;
    }
}
