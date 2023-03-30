//
//  ViewController.swift
//  Instagrid
//
//  Created by pierrick viret on 30/03/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var middleBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedLayout(for: middleBtn)
        // Do any additional setup after loading the view.
    }


    @IBAction func modifieLayout(_ sender: UIButton) {
        selectedLayout(for: sender)
    }

    // display selected image behind the right Layout button
    private func selectedLayout(for button : UIButton){
        let image = UIImage(named: "Selected")

        switch button.tag {
        case 0: leftBtn.setImage(image, for: .normal)
                setupImage(for: leftBtn)
                middleBtn.setImage(nil, for: .normal)
                rightBtn.setImage(nil, for: .normal)

        case 1: leftBtn.setImage(nil, for: .normal)
                middleBtn.setImage(image, for: .normal)
                setupImage(for: middleBtn)
                rightBtn.setImage(nil, for: .normal)

        case 2: leftBtn.setImage(nil, for: .normal)
                middleBtn.setImage(nil, for: .normal)
                rightBtn.setImage(image, for: .normal)
                setupImage(for: rightBtn)
        default : break
        }
    }
    
    //setup Image
    private func setupImage(for button: UIButton){
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
    }
    
}

