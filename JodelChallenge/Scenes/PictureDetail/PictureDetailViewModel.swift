//
//  PictureDetailViewModel.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 22.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import UIKit

protocol PictureDetailProtocol: NSObjectProtocol {

}

class PictureDetailViewModel {

    var delegate: PictureDetailProtocol?
    
    var flickrImage: FlickrPhoto? 
  
}
