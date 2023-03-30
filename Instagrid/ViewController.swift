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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        middleBtn.showCheck()
        // Do any additional setup after loading the view.
    }


    @IBAction func modifieLayout(_ sender: UIButton) {
        selectedLayout(for: sender)
    }

    // display selected image behind the right Layout button
    private func selectedLayout(for button : UIButton){
        
        switch button.tag {
        case 0: leftBtn.showCheck()
                middleBtn.notShowCheck()
                rightBtn.notShowCheck()

        case 1: leftBtn.notShowCheck()
                middleBtn.showCheck()
                rightBtn.notShowCheck()

        case 2: leftBtn.notShowCheck()
                middleBtn.notShowCheck()
                rightBtn.showCheck()
        default : break
        }
    }
    
}

