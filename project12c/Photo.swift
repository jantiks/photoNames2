//
//  Photo.swift
//  project12c
//
//  Created by Tigran on 12/18/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class Photo: NSObject, Codable {
    var name: String
    var image: String
    
    init(name:String, image: String) {
        self.name = name
        self.image = image
    }
}
