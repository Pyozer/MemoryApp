//
//  Theme.swift
//  Memory
//
//  Created by i162431 on 22/02/2018.
//  Copyright © 2018 i162431. All rights reserved.
//

import Foundation
import UIKit.UIColor

class Theme {
    
    private(set) var emojies: [String];
    private(set) var color: UIColor;
    private(set) var name: String;
    
    init(emojies: [String], color: UIColor, name: String) {
        self.emojies = emojies
        self.color = color
        self.name = name
    }
    
    public func getNbEmojies() -> Int {
        return emojies.count
    }
    
    public func removeEmojie(index: Int) -> String {
        return emojies.remove(at: index)
    }
}
