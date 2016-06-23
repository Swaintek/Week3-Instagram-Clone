//
//  Additions.swift
//  ISTGRM
//
//  Created by David Swaintek on 6/21/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resize (image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(x: 0, y: 0, width: size.width,
            height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    func normalizedImage() -> UIImage {
        
        if (self.imageOrientation == UIImageOrientation.Up) {
            return self;
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.drawInRect(rect)
        
        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return normalizedImage;
    }

}

extension NSURL {
    static func imageURL() -> NSURL {
        guard let documentsDirectory = NSFileManager.defaultManager()
            .URLsForDirectory(.DocumentDirectory,
                              inDomains: .UserDomainMask)
            .first else {fatalError("Error getting documents directory")}
            return documentsDirectory.URLByAppendingPathComponent("image")}
}