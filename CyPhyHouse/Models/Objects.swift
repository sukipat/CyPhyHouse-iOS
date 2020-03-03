//
//  Objects.swift
//  CyPhyHouse
//
//  Created by Suki on 3/2/20.
//  Copyright © 2020 CSL. All rights reserved.
//

import Foundation
import UIKit

class Object {
    var coord: CGPoint = CGPoint.zero
    var description: String = ""
    let image: UIImage
    init(type: String, picture: UIImage) {
        self.description = type
        self.image = picture
    }
}

class DroneGoal: Object {
    init(location: CGPoint) {
        super.init(type: "DroneGoal", picture: UIImage(named: "DroneGoal")!)
        self.coord = location
    }
}

class CarGoal: Object {
    init(location: CGPoint) {
        super.init(type: "CarGoal", picture: UIImage(named: "CarGoal")!)
        self.coord = location
    }
}

class Obstacle: Object {
    var radius: CGFloat
    init(location: CGPoint, rad: CGFloat) {
        self.radius = rad
        super.init(type: "Obstacle", picture: UIImage(named: "Obstacle")!)
        self.coord = location
    }
}
