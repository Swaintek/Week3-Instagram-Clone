//
//  FiltersPreviewViewController.swift
//  ISTGRM
//
//  Created by David Swaintek on 6/23/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

class FiltersPreviewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    class func id() -> String{
        return String(self)
    }
    
    weak var delegate: FiltersPreviewViewControllerDelegate?
    let filters = [Filters.shared.original, Filters.shared.vintage, Filters.shared.comic, Filters.shared.pixelate, Filters.shared.sketch, Filters.shared.bw, Filters.shared.chrome]
    var post = Post()
        
        
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension FiltersPreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func configureCellForIndexPath(indexPath: NSIndexPath) -> ImageCollectionViewCell {
        
        let imageCell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath)
        as! ImageCollectionViewCell
        
        self.filters[indexPath.row](post.image, completion: {imageCell.imageView.image = $0})
        
        return imageCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.configureCellForIndexPath(indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let delegate = self.delegate else { return }
        
        let imageCell = collectionView.cellForItemAtIndexPath(indexPath) as! ImageCollectionViewCell
        
        if let image = imageCell.imageView.image {
            delegate.didFinishPickingImage(true, image: image)
        } else {
            delegate.didFinishPickingImage(false, image: nil)
        }
    }
    
}
























