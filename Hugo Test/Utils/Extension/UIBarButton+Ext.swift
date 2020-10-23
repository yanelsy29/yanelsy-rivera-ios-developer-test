//
//  UIBarButton+Ext.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/21/20.
//

import Foundation
import UIKit


extension UIBarButtonItem {
    
    static func barButton(image: UIImage?, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.imageView?.layer.cornerRadius = 16
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(target, action: action, for: .touchUpInside)

        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 32).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 32).isActive = true

        return barButtonItem
    }

    
}
