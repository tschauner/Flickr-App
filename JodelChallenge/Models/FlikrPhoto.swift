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
import RealmSwift

@objcMembers class FlickrPhoto: Object, Codable {
    
    dynamic var isfriend: Int = 0
    dynamic var farm: Int = 0
    dynamic var id: String = ""
    dynamic var secret: String = ""
    dynamic var owner: String = ""
    dynamic var title: String = ""
    dynamic var server: String = ""
    dynamic var ispublic: Int = 0
    dynamic var isfamily: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case isfriend
        case farm
        case id
        case secret
        case owner
        case title
        case server
        case ispublic
        case isfamily
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        isfriend = try values.decode(Int.self, forKey: .isfriend)
        farm = try values.decode(Int.self, forKey: .farm)
        id = try values.decode(String.self, forKey: .id)
        secret = try values.decode(String.self, forKey: .secret)
        title = try values.decode(String.self, forKey: .title)
        server = try values.decode(String.self, forKey: .server)
        ispublic = try values.decode(Int.self, forKey: .ispublic)
        isfamily = try values.decode(Int.self, forKey: .isfamily)
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(farm, forKey: .farm)
        try values.encode(secret, forKey: .secret)
        try values.encode(title, forKey: .title)
        try values.encode(server, forKey: .server)
        try values.encode(ispublic, forKey: .ispublic)
        try values.encode(isfamily, forKey: .isfamily)
    }
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

    
//    convenience init?(data: Data) {
//        guard let me = try? JSONDecoder().decode(FlickrPhoto.self, from: data) else { return nil }
//        self = me
//    }
//
//    init?(_ json: String, using encoding: String.Encoding = .utf8) {
//        guard let data = json.data(using: encoding) else { return nil }
//        self.init(data: data)
//    }
//
//    init?(fromURL url: String) {
//        guard let url = URL(string: url) else { return nil }
//        guard let data = try? Data(contentsOf: url) else { return nil }
//        self.init(data: data)
//    }
//
//    var jsonData: Data? {
//        return try? JSONEncoder().encode(self)
//    }
    
//    var json: String? {
//        guard let data = self.jsonData else { return nil }
//        return String(data: data, encoding: .utf8)
//    }
}
