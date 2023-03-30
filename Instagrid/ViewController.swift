//
//  ViewController.swift
//  Instagrid
//
//  Created by pierrick viret on 30/03/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rightBtn: layoutButton!
    @IBOutlet weak var middleBtn: layoutButton!
    @IBOutlet weak var leftBtn: layoutButton!
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedLayout(index: 1)
    }

    @IBAction func modifieLayout(_ sender: UIButton) {
        selectedLayout(index: sender.tag)
    }

    // display selected image behind the right Layout button
    private func selectedLayout(index: Int){
        switch index {
        case 0: leftBtn.showCheck()
                middleBtn.notShowCheck()
                rightBtn.notShowCheck()
                bottomRightView.isHidden = false
                topRightView.isHidden = true

        case 1: leftBtn.notShowCheck()
                middleBtn.showCheck()
                rightBtn.notShowCheck()
                bottomRightView.isHidden = true
                topRightView.isHidden = false

        case 2: leftBtn.notShowCheck()
                middleBtn.notShowCheck()
                rightBtn.showCheck()
                bottomRightView.isHidden = false
                topRightView.isHidden = false
        default : break
        }
    }
    
    

}

