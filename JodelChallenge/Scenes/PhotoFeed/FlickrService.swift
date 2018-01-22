//
//  FlickrService.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 21.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import UIKit
import FlickrKit
import RealmSwift

class FlickrService {
    
typealias Closure<T> = ((T) -> Void)
    

    func fetchPhotos(page: Int = 0, with completion: @escaping Closure<[FlickrPhoto]>, failure: @escaping Closure<Error>) {
        
        let flicker = FlickrKit.shared()
        let flickrInteresting = FKFlickrInterestingnessGetList()
        flicker.initialize(withAPIKey: "92111faaf0ac50706da05a1df2e85d82", sharedSecret: "89ded1035d7ceb3a")
        flickrInteresting.page = String(page)
        flickrInteresting.per_page = "10"

        
        flicker.call(flickrInteresting) { (response, error) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                if let response = response, let photoArray = FlickrKit.shared().photoArray(fromResponse: response) {
                    do {
                        let jsonDecoder = JSONDecoder()
                        
                        let photosData = try JSONSerialization.data(withJSONObject: photoArray, options: .prettyPrinted)
                        let photos = try jsonDecoder.decode([FlickrPhoto].self, from: photosData)
                        completion(photos)
                        
                    } catch let error {
                        failure(error)
                    }
                } else {
                    if let error = error {
                        failure(error)
                    }
                }
            })
        }
    }
    
    func fetchPhotosFromRealm(results: @escaping Closure<[FlickrPhoto]>) {
        RealmManager.shared.fetchAll { (photos: [FlickrPhoto]) in
            results(photos)
        }
    }
    
    func savePhotosToRealm(photos: [FlickrPhoto]) {
        photos.forEach { (photo) in
            RealmManager.shared.create(photo, updateExisting: true, complete: {
                
            })
        }
        
    }
}
