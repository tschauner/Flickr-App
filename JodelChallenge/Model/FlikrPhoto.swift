//
//  PictureModel.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 20.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import UIKit
import FlickrKit
import AlamofireImage

struct FlickrPhoto: Codable {
    let isfriend, farm : Int
    let id, secret, owner, title, server: String
    let ispublic, isfamily: Int
}

extension FlickrPhoto {
    
    var imageURL: URL {
        let flickr = FlickrKit()
        let farmString: String = String(farm)
        return flickr.photoURL(for: .large1024, photoID: id, server: server, secret: secret, farm: farmString)
    }
    
    var imageView: UIImageView {
        let imageView = UIImageView()
        imageView.af_setImage(withURL: imageURL)
        return imageView
    }
}

// MARK: Convenience initializers

extension FlickrPhoto {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(FlickrPhoto.self, from: data) else { return nil }
        self = me
    }
    
    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }
    
    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }
    
    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
