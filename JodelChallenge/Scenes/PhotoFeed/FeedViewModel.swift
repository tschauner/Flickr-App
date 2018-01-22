//
//  PictureViewModel.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 20.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import Foundation
import FlickrKit
import SVProgressHUD

protocol FeedProtocol: NSObjectProtocol {
    func photosUpdated()
    func showErrorAlert(withText text: String)
}

class FeedViewModel {
    
    let service = FlickrService()
    weak var delegate: FeedProtocol?
    var page = 0
    
    private(set) var pictures: [FlickrPhoto] = [FlickrPhoto]()
    
    func nextPage() {
        page += 1
        fetchPhotos()
    }
    
    func fetchPhotos() {
        service.fetchPhotos(page: page, with: { [weak self] photos in
            if self?.page == 0 {
               self?.pictures = photos
            } else {
                self?.pictures.append(contentsOf: photos)
                self?.service.savePhotosToRealm(photos: photos)
            }
            
            self?.delegate?.photosUpdated()
           
        }) { (error) in
            self.delegate?.showErrorAlert(withText: error.localizedDescription)
            self.fetchPhotosFromRealm()
        }
    }
    
    func fetchPhotosFromRealm() {
        service.fetchPhotosFromRealm { [weak self] photos in
            self?.pictures = photos
            self?.delegate?.photosUpdated()
        }
    }
}





