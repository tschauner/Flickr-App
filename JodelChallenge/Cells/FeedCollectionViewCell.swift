//
//  FeedCollectionViewCell.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 20.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import UIKit
import AlamofireImage

class FeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    static var identifier: String {
        return String(describing: FeedCollectionViewCell.self)
    }
    
    
    func configure(image: URL) {

    }
    
    func setupViews() {
        
    }

}
