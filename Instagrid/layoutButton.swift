//
//  layoutButton.swift
//  Instagrid
//
//  Created by pierrick viret on 30/03/2023.
//

import UIKit

class layoutButton: UIButton {

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
