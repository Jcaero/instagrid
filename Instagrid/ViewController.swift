//
//  ViewController.swift
//  Instagrid
//
//  Created by pierrick viret on 30/03/2023.
//

import UIKit
import PhotosUI

// UIImagePickerViewController
// CGAffine

class ViewController: UIViewController {
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
    
    @IBOutlet weak var topLeftBtn: UIButton!
    
    var libraryPicker: PHPickerViewController?
    var viewSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedLayout(index: 1)
        setupLibrary()
        initGesturePhoto()
        initGestureSwipe()
    }
    
    // identifie orientation of the device
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            swipeUpLbl.text = "Swipe left to share"
            arrowIV.image = UIImage(named: "Arrow Left")
        } else {
            swipeUpLbl.text = "Swipe up to share"
            arrowIV.image = UIImage(named: "Arrow Up")
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
    
    // action when touch  cross
    @IBAction func selectedImage(_ sender: UIView) {
        viewSelected = sender.tag
        present(libraryPicker!, animated: true,completion: nil)
    }
}

    //add gesture recognizer for change picture
extension ViewController {
    private func initGesturePhoto() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)) )
        
        topLeftIV.addGestureRecognizer(tap)
        topLeftIV.isUserInteractionEnabled = true
    }
    
    // call when a picture is tap for change picture
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        viewSelected = sender.view?.tag
        present(libraryPicker!, animated: true,completion: nil)
    }

    private func initGestureSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(specificService(_:)))
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        self.view.isUserInteractionEnabled = true
    }

    // convert view in image and show Activity controller
    @objc func specificService(_ sender: UISwipeGestureRecognizer) {
        //create image
        let image = photosView.getImage()
        var items = [UIImage]()
        items.append(image)
        //display UIActivity
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}

// gesture of library
extension ViewController : PHPickerViewControllerDelegate {

    func setupLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .automatic
        
        libraryPicker = PHPickerViewController(configuration: configuration)
        libraryPicker?.delegate = self
    }
    // call when user finish with library
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        guard let first = results.first else { return }
        let newPhotoProvider = first.itemProvider

        guard newPhotoProvider.canLoadObject(ofClass: UIImage.self) else { return }

        newPhotoProvider.loadObject(ofClass: UIImage.self) { image, error in

            DispatchQueue.main.async {
                if let e = error {
                    print(e.localizedDescription)
                }
                guard let newImage = image as? UIImage else { return }
                switch self.viewSelected {
                case 1: self.topLeftIV.image = newImage
                    self.topLeftBtn.isHidden = true
                case 2: self.topRightIV.image = newImage
                case 3: self.bottomLeftIV.image = newImage
                case 4: self.bottomRightIV.image = newImage
                default: print("image non ok")
                }
            }
        }
    }
}
