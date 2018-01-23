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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var shadowView: UIView!
    
    private var gradient: CAGradientLayer?
    var flickrPhoto: FlickrPhoto?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
        configureGradient()
    }
    
    // transforms cell when pressed
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : CGAffineTransform.identity
                self.shadowView.alpha = self.isHighlighted ? 1 : 0
            }

        }
    }

    /// sets up gradient layer
    private func configureGradient() {
        if let _ = gradient {
            return
        }
        gradient = CAGradientLayer()
        gradient?.colors = [UIColor.clear.cgColor, UIColor(white: 0.2, alpha: 0.9).cgColor]
        pictureImageView.layer.addSublayer(gradient!)
    }
    
    
    /// gradient layer in top of image view
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientHeight: CGFloat = 70
        gradient?.frame = CGRect.init(x: 0,
                                      y: pictureImageView.bounds.maxY - gradientHeight,
                                      width: pictureImageView.bounds.width,
                                      height: gradientHeight)
    }
    
    
    /// resets the cell to reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pictureImageView.af_cancelImageRequest()
        pictureImageView.image = nil
    }
    
    
    /// static identifier
    static var identifier: String {
        return String(describing: FeedCollectionViewCell.self)
    }
    
    
    
    /// configures the colleciton view cell
    ///
    /// - Parameter photo: flickrphoto model
    func configure(photo: FlickrPhoto) {
        flickrPhoto = photo
        pictureImageView.heroID = "\(photo.id)_name"
        pictureImageView.af_cancelImageRequest()
        activityIndicator.startAnimating()
        pictureImageView.af_setImage(withURL: photo.imageURL, placeholderImage: nil, filter: nil, progress: { (progress) in
            
        }, progressQueue: .main, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: false) { [weak self] (completion) in
            self?.activityIndicator.stopAnimating()
            //self?.shadowView.alpha = 1
        }
        
        imageNameLabel.heroID = "\(photo.id)_name"
        imageNameLabel.text = photo.title
    }
    
    
    /// setup all views
    func setupViews() {
        pictureImageView.clipsToBounds = true
        pictureImageView.layer.cornerRadius = 20
        
        shadowView.alpha = 0
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.cornerRadius = 20
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 10
    
    }

}
