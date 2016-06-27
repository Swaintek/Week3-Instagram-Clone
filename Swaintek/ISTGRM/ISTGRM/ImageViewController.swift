//
//  ViewController.swift
//  ISTGRM
//
//  Created by David Swaintek on 6/20/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FiltersPreviewViewControllerDelegate
{
    var post = Post()
    
    class func id() -> String
    {
        return String(self)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    lazy var imagePicker = UIImagePickerController()

    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
        self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setup()
    {
        self.navigationItem.title = "Dave's Picture Factory"
    }
    
    func setupAppearance()
    {
        self.imageView.layer.cornerRadius = 3.0
    }
    
    func presentActionsSheet()
    {
        let actionSheet = UIAlertController(title: "Source", message: "Please select the source type", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.presentImagePicker(.Camera)
        }
        let photosAction = UIAlertAction(title: "Photos", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType)
    {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addButtonSelected(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionsSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else {return}
        
        self.post = Post(image: image)
        
        self.performSegueWithIdentifier(FiltersPreviewViewController.id(), sender: self.post)
    }
    
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        guard let img = self.imageView.image else { return }
        self.post = Post(image: img)
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        
        API.shared.write(self.post) { (success) in
            if success {
                let alert = UIAlertController(title: "Image saved!", message: nil, preferredStyle: .Alert)
                let excellent = UIAlertAction(title: "Excellent.", style: .Default, handler: { (action) in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                alert.addAction(excellent)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FiltersPreviewViewController.id() {
            guard let filtersPreviewViewController = segue.destinationViewController
                as? FiltersPreviewViewController else { return }
            
            filtersPreviewViewController.delegate = self
            filtersPreviewViewController.post = sender as! Post
        }
    }
    
    func didFinishPickingImage(success: Bool, image: UIImage?) {
        if success {
            guard let image = image else { return }
            self.imageView.image = image
        } else {
            print("Unsuccessful at retrieving image")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String :AnyObject]?)
//    {
//        self.imageView.image = image
//        self.editButton.enabled = true
//        self.saveButton.enabled = true
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController)
//    {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    


}

extension ImageViewController {
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image // passed in as param of delegate function
        Filters.shared.originalImg = image // image reset to original non filtered pix
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}






















