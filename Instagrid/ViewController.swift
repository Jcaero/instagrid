//
//  ViewController.swift
//  Instagrid
//
//  Created by pierrick viret on 30/03/2023.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var middleBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    
    @IBOutlet weak var swipeUpLbl: UILabel!
    @IBOutlet weak var arrowIV: UIImageView!
    @IBOutlet weak var photosView: ShadowView!
    
    @IBOutlet weak var topLeftIV: UIImageView!
    @IBOutlet weak var topRightIV: UIImageView!
    @IBOutlet weak var bottomLeftIV: UIImageView!
    @IBOutlet weak var bottomRightIV: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var viewSelected: Int = 1
    
    var deplacementValue: CGFloat = 0
    var transformX: CGFloat = 0
    var transformY: CGFloat = 0
    
    var swipeGesture = UISwipeGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // init transform value
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        deplacementValue = height>width ? -height : -width
        
        // setup library
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        initGestureSwipe()
        
        selectedLayout(index: 1)
        updateOrientation()
    }

    private func initGestureSwipe() {
        swipeGesture = UISwipeGestureRecognizer(target: self,
                                                action: #selector(specificService(_:)))
        swipeGesture.direction = .up
        self.view.addGestureRecognizer(swipeGesture)
        self.view.isUserInteractionEnabled = true
    }
    
    // identifie orientation of the device
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        updateOrientation()
    }
    
    private func updateOrientation() {
        switch UIDevice.current.orientation {
        case .portrait, .faceUp, .faceDown, .portraitUpsideDown, .unknown:
            swipeUpLbl.text = "Swipe up to share"
            arrowIV.image = UIImage(named: "Arrow Up")
            transformX = 0
            transformY = deplacementValue
            swipeGesture.direction = .up
            
        case .landscapeLeft, .landscapeRight:
            swipeUpLbl.text = "Swipe left to share"
            arrowIV.image = UIImage(named: "Arrow Left")
            transformX = deplacementValue
            transformY = 0
            swipeGesture.direction = .left
            
        default: break
        }
    }

    @IBAction func modifieLayout(_ sender: UIButton) {
        selectedLayout(index: sender.tag)
    }

    // display selected image behind the right Layout button
    private func selectedLayout(index: Int) {
        resetView()
        
        switch index {
        case 0:
            leftBtn.showCheck()
            topRightView.isHidden = true
            
        case 1:
            middleBtn.showCheck()
            bottomRightView.isHidden = true
            
        case 2:
            rightBtn.showCheck()
            
        default : break
        }
    }
    
    // reset view
    private func resetView() {
        [leftBtn, middleBtn, rightBtn].forEach {
            $0?.notShowCheck()
        }
        bottomRightView.isHidden = false
        topRightView.isHidden = false
    }
    
    // action when touch
    @IBAction func selectedImage(_ sender: UIButton) {
        viewSelected = sender.tag
        present(imagePicker, animated: true,completion: nil)
    }
}

// gesture of library
extension ViewController: UIImagePickerControllerDelegate {
    
    // call when user finish with library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        switch self.viewSelected {
        case 1: self.topLeftIV.image = image
        case 2: self.topRightIV.image = image
        case 3: self.bottomLeftIV.image = image
        case 4: self.bottomRightIV.image = image
        default: print("image non ok")
        }
    }
}
// UIactivity gestion
extension ViewController {
    
    @objc func specificService(_ sender: UISwipeGestureRecognizer) {
        // animation
        let translationTransform = CGAffineTransform(translationX: transformX , y: transformY)
        
        UIView.animate(withDuration: 0.3) {
            self.photosView.transform = translationTransform
        } completion: { finish in
            if finish == false { return }
            self.presentActivityController()
        }
    }
    
    private func presentActivityController() {
        let image = photosView.getImage()
        
        //display UIActivity
        let ac = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(ac, animated: true)
        
        // display view when UIActivity finish
        ac.completionWithItemsHandler = {(activity, success, items, error) in
            UIView.animate(withDuration: 0.3) {
                self.photosView.transform = CGAffineTransform(translationX: 0 , y: 0)
            }
        }
    }
}



