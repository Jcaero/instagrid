//
//  UIButton.swift
//  Instagrid
//
//  Created by pierrick viret on 02/04/2023.
//

import UIKit

extension UIButton {

    func showCheck(){
        let image = UIImage(named: "Selected")
        self.setImage(image, for: .normal)
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
    }

    func notShowCheck(){
        self.setImage(nil, for: .normal)
    }
}
