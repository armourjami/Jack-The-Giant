//
//  CloudClass.swift
//  Jack The Giant
//
//  Created by Jamie Armour on 5/06/17.
//  Copyright © 2017 Jamie Armour. All rights reserved.
//

import SpriteKit

class CloudsController {
    
    var lastCloudsPositionY = CGFloat();
    
    func shuffle (cloudsArray: [SKSpriteNode]) -> [SKSpriteNode]  {
        var array = cloudsArray;
        for i in stride(from: array.count - 1, to: 0, by: -1) {
            let j = Int(arc4random_uniform(UInt32(i - 1)));
            swap(&array[i], &array[j]);
        }
        return array;
    }
    
    func createClouds() -> [SKSpriteNode] {
        var clouds = [SKSpriteNode]();
        
        for i in 0...2 {
            clouds.append(SKSpriteNode(imageNamed: "Cloud \(i + 1)"));
            clouds[i].name = String(i);
            clouds[i].xScale = 0.9;
            clouds[i].yScale = 0.9;
            clouds[i].physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: clouds[i].size.width - 5, height: clouds[i].size.height - 6));
            clouds[i].physicsBody?.affectedByGravity = false;
            clouds[i].physicsBody?.restitution = 0;
            clouds[i].physicsBody?.categoryBitMask = ColliderType.CLOUD;
            clouds[i].physicsBody?.collisionBitMask = ColliderType.PLAYER;
        }
        clouds.append(SKSpriteNode(imageNamed: "Dark Cloud"));
        clouds[clouds.count - 1].physicsBody = SKPhysicsBody(rectangleOf: clouds[clouds.count - 1].size);
        clouds[clouds.count - 1].physicsBody?.affectedByGravity = false;
        clouds[clouds.count - 1].physicsBody?.categoryBitMask = ColliderType.DARK_CLOUD_AND_COLLECTABLES;
        
        
        clouds = shuffle(cloudsArray: clouds);
        
        return clouds;
    }
    
    private func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum);
    }
    
    func arrangeCloudsInScene (scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat,  minX: CGFloat, maxX: CGFloat, initialClouds: Bool) {
        var clouds = createClouds();
        
        if initialClouds {
            while clouds[0].name == "Dark Cloud" {
                clouds = shuffle(cloudsArray: clouds);
            }
        }
        
        var positionY = CGFloat();
        
        if initialClouds {
            positionY = center - 100;
        } else {
            positionY = lastCloudsPositionY;
        }
        
        var random = 0;
        
        for i in 0...clouds.count - 1 {
            var randomX = CGFloat();
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: center + 90, secondNum: maxX);
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX);
                random = 0;
            
            }
            clouds[i].position = CGPoint(x: randomX, y: positionY);
            clouds[i].zPosition = 3;
            scene.addChild(clouds[i]);
            positionY -= distanceBetweenClouds;
            lastCloudsPositionY = positionY;
        }
    }
}
