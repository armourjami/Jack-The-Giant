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
    
    func createClouds() -> [SKSpriteNode] {
        var clouds = [SKSpriteNode]();
        
        
        for i in 0...2 {
            clouds.append(SKSpriteNode(imageNamed: "Cloud \(i + 1)"));
            clouds[i].name = String(i);
            clouds[i].xScale = 0.9;
            clouds[i].yScale = 0.9;
            
        }
        clouds.append(SKSpriteNode(imageNamed: "Dark Cloud"));
        clouds[clouds.count - 1].name = String(clouds.count - 1);
        
        return clouds;
    }
    
    func arrangeCloudsInScene (scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat,  minX: CGFloat, maxX: CGFloat, initialClouds: Bool) {
        var clouds = createClouds();
        
        if initialClouds {
            while clouds[0].name == "Dark Cloud" {
                //shuffle clouds
            }
        }
        
        var positionY = CGFloat();
        
        if initialClouds {
            positionY = center - 100;
        } else {
            positionY = lastCloudsPositionY;
        }
        
        for i in 0...clouds.count - 1 {
            clouds[i].position = CGPoint(x: 0, y: positionY);
            clouds[i].zPosition = 3;
            scene.addChild(clouds[i]);
            positionY -= distanceBetweenClouds;
            lastCloudsPositionY = positionY;
        }
    }
}
