//
//  PictureDetailViewModel.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 22.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import UIKit

protocol PhotoDetailProtocol: NSObjectProtocol {

}

class PhotoDetailViewModel {

    var delegate: PhotoDetailProtocol?
    
    var flickrImage: FlickrPhoto? 
  
}
