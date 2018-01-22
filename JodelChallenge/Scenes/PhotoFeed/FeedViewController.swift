//
//  FeedViewController.swift
//  JodelChallenge
//
//  Created by Philipp Tschauner on 20.01.18.
//  Copyright © 2018 Jodel. All rights reserved.
//

import UIKit
import Hero

extension FeedViewController: FeedProtocol {
    
    func photosUpdated() {
        self.feedCollectionView.reloadData()
        refreshControl.endRefreshing()
        loadingNextPage = false
        pageLabel.text = "\(feedViewModel.page + 1)"
    }
}


class FeedViewController: UIViewController {

    @IBOutlet weak var feedCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    let feedViewModel = FeedViewModel()
    var loadingNextPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedViewModel.delegate = self
        setupCollectionView()
        setupPageView()
        fetchData()
        setupNavigationBar()
    }

    
    func setupCollectionView() {
        feedCollectionView.scrollsToTop = true
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        
        feedCollectionView.register(UINib(nibName: FeedCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        
        feedCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    }
    
    @objc func fetchData() {
        refreshControl.beginRefreshing()
        feedViewModel.fetchPhotos()
    }
    
    func setupPageView() {
        pageView.layer.cornerRadius = pageView.frame.size.height/2
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Flickrgram"
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func showErrorAlert(withText text: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(title: "OOOOPS", contentText: text, actions: [okAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentCell = sender as? FeedCollectionViewCell,
            let vc = segue.destination as? PictureDetailViewController {
            vc.pictureDetailViewModel.flickrImage = currentCell.flickrPhoto
        }
    }

}

extension FeedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedViewModel.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as? FeedCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = self.feedViewModel.pictures[indexPath.row]
        cell.configure(photo: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row >= feedViewModel.pictures.count - 5 && !loadingNextPage {
            loadingNextPage = true
            feedViewModel.nextPage()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = view.frame.height/1.5
        let size = CGSize(width: view.frame.width, height: height)
        
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        performSegue(withIdentifier: "showDetail", sender: cell)
    }
    
}




