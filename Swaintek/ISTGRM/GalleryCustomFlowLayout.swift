//
//  GalleryCustomFlowLayout.swift
//  ISTGRM
//
//  Created by David Swaintek on 6/22/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

class GalleryCustomFlowLayout: UICollectionViewFlowLayout {
    
    let columns: Int
    
    let space: CGFloat = 1.0
    
    init(columns: Int = 3)
    {
        self.columns = columns
        
        super.init()
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init (coder:) has not been implemented")
    }
    
    func setup() {
        self.minimumLineSpacing = self.space
        self.minimumInteritemSpacing = self.space
        self.itemSize = CGSize(width: self.itemWidth(), height: self.itemWidth() * 2)
    }
    
    func itemWidth() -> CGFloat{
        let width = UIScreen.mainScreen().bounds.width
        let availableWidth = width - (CGFloat(self.columns) * self.space)
        return availableWidth / CGFloat(self.columns)
    }

}
