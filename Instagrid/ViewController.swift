//
//  ViewController.swift
//  Instagrid
//
//  Created by pierrick viret on 30/03/2023.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedLayout(index: 1)
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            swipeUpLbl.text = "Swipe left to share"
            arrowIV.image = UIImage(named: "Arrow Left")
        }else {
            swipeUpLbl.text = "Swipe up to share"
            arrowIV.image = UIImage(named: "Arrow Up")
        }
    }
    
    @IBAction func modifieLayout(_ sender: UIButton) {
        selectedLayout(index: sender.tag)
    }

    // display selected image behind the right Layout button
    private func selectedLayout(index: Int){
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

}



