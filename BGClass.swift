//
//  BGClass.swift
//  Jack The Giant
//
//  Created by Jamie Armour on 5/06/17.
//  Copyright © 2017 Jamie Armour. All rights reserved.
//

import Foundation
import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBackground (camera: SKCameraNode) {
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3;
        }
    }
    
}
