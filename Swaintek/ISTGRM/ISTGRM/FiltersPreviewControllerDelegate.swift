//
//  FiltersPreviewControllerDelegate.swift
//  ISTGRM
//
//  Created by David Swaintek on 6/23/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import Foundation
import UIKit

protocol FiltersPreviewViewControllerDelegate: class
{
    func didFinishPickingImage(success: Bool, image: UIImage?)
}