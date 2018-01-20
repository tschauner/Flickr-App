//
//  PictureViewModel.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 20.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import Foundation

class PictureViewModel {
    
    private var pictures: [Picture] = []
    
    func picturesCount() -> Int {
        return pictures.count
    }
    
    func getPicture(atIndex indexPath: IndexPath) -> Picture {
        return pictures[indexPath.item]
    }
    
}
