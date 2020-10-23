//
//  UIStoryboard+Ext.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/21/20.
//

import UIKit

public enum AppStoryboard: String {
    case main = "Main"
}

extension UIViewController {
    
    class func instantiate<T: UIViewController>() -> T {
        let storyboard = UIStoryboard(name: AppStoryboard.main.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
