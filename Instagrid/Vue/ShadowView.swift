//
//  ShadowView.swift
//  Instagrid
//
//  Created by pierrick viret on 02/04/2023.
//

import UIKit

class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.8
    }
}
