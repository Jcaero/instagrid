//
//  View.swift
//  Instagrid
//
//  Created by pierrick viret on 03/04/2023.
//

import Foundation
import UIKit

extension UIView {
    
    func getImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image{ rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }
        return image
    }
}