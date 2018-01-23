//
//  PictureDetailViewController.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 21.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import UIKit
import Hero
import AlamofireImage

extension PictureDetailViewController: PictureDetailProtocol {
    
    
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

class PictureDetailViewController: UIViewController {
    
    @IBOutlet weak var pictureNameLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    var pictureDetailViewModel = PictureDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        setupViews()
        initPanGesture()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateButton()
    }
    
    
    /// setup views
    /// cache image
    /// sets hero ids
    func setupViews() {
        
        guard let photo = pictureDetailViewModel.flickrImage else { return }
        
        pictureNameLabel.heroID = "\(photo.id)_name"
        pictureImageView.heroID = "\(photo.id)_name"
        
        pictureImageView.af_setImage(withURL: photo.imageURL)
        pictureNameLabel.text = photo.title
        
    }
    
    
    /// initializes the pan gesture
    func initPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        pictureImageView.isUserInteractionEnabled = true
        pictureImageView.addGestureRecognizer(pan)
        pictureImageView.backgroundColor = .gray
    }
    
    
    
    /// pan gesture which handles hero animation
    ///
    /// - Parameter pan: pan gesture for views
    @objc func didPan(pan: UIPanGestureRecognizer) {
        
        let translation = pan.translation(in: nil)
        let progress = translation.y / 2 / pictureImageView.frame.height
        print(progress)
        switch pan.state {
        case .began:
            // begin the transition as normal
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(progress)
            
            // update views' position (limited to only vertical scroll)
            Hero.shared.apply(modifiers: [.position(CGPoint(x: pictureImageView.center.x, y:translation.y + pictureImageView.center.y))], to: pictureImageView)
            Hero.shared.apply(modifiers: [.position(CGPoint(x: pictureNameLabel.center.x, y:translation.y + pictureNameLabel.center.y))], to: pictureNameLabel)
            
        default:
            // end or cancel the transition based on the progress and user's touch velocity
            if progress + pan.velocity(in: nil).y / view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    
    
    /// shows the button after the view is loaded
    func animateButton() {
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
            self.closeButton.alpha = 1
        }, completion: nil)
    }
    
    
    /// sets up the close button
    func setupButton() {
        closeButton.alpha = 0
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    
    /// dismiss action for vc
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
