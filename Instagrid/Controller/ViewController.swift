//
//  ViewController.swift
//  Instagrid
//
//  Created by pierrick viret on 30/03/2023.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UINavigationControllerDelegate {
    //selected button
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var middleBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    
    // view containing user creation
    @IBOutlet weak var photosView: ShadowView!
    
    //view containing button and picture
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    
    // arrow and label for swipe
    @IBOutlet weak var swipeUpLbl: UILabel!
    @IBOutlet weak var arrowIV: UIImageView!
    
    //Image selected by user
    @IBOutlet weak var topLeftIV: UIImageView!
    @IBOutlet weak var topRightIV: UIImageView!
    @IBOutlet weak var bottomLeftIV: UIImageView!
    @IBOutlet weak var bottomRightIV: UIImageView!
    

    private var imagePicker = UIImagePickerController()
    private var viewSelected: Int = 1
    
    private var swipeGesture = UISwipeGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup library
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        initGestureSwipe()
        
        selectedLayout(index: 1)
        updateOrientation()
    }

    // init of swipe Gesture with up direction and add in superview
    private func initGestureSwipe() {
        swipeGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(specificService)
        )
        
        swipeGesture.direction = .up
        self.view.addGestureRecognizer(swipeGesture)
        self.view.isUserInteractionEnabled = true
    }
    
    // call when orientation of the device change
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        updateOrientation()
    }
    
    // identifie orientation of the device and change the display
    private func updateOrientation() {
        switch UIDevice.current.orientation {
        case .portrait, .faceUp, .faceDown, .portraitUpsideDown, .unknown:
            swipeUpLbl.text = "Swipe up to share"
            arrowIV.image = UIImage(named: "Arrow Up")
            
            swipeGesture.direction = .up
            
        case .landscapeLeft, .landscapeRight:
            swipeUpLbl.text = "Swipe left to share"
            arrowIV.image = UIImage(named: "Arrow Left")

            swipeGesture.direction = .left
            
        default: break
        }
    }

    //  IBOutletCollection of selected layout button
    // call selectedLayout function with tag
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
    
    // action when touch image area
    @IBAction func selectedImage(_ sender: UIButton) {
        //value of the button
        viewSelected = sender.tag
        //show library
        present(imagePicker, animated: true,completion: nil)
    }
}

// gesture of library
extension ViewController: UIImagePickerControllerDelegate {
    
    // call when user finish with library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        //put image in the right view
        switch self.viewSelected {
        case 1: self.topLeftIV.image = image
        case 2: self.topRightIV.image = image
        case 3: self.bottomLeftIV.image = image
        case 4: self.bottomRightIV.image = image
        default: print("image non ok")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

// UIactivity gestion
extension ViewController {
    
    // call when swipe recognize
    @objc func specificService() {

        // height and width of the device screen
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        // identifie the device orientation and affect the distance
        let translationTransform = height > width ? CGAffineTransform(translationX: 0, y: -photosView.frame.maxY-5) : CGAffineTransform(translationX: -photosView.frame.maxX-5, y: 0)
        
        // animation
        UIView.animate(withDuration: 0.3) {
            self.photosView.transform = translationTransform
        } completion: { finish in
            if finish == false { return }
            self.presentActivityController()
        }
    }
    
    // display activity Controller
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



