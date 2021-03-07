//
//  UIStoryBoard+Extension.swift
//  Movies
//
//  Created by Praveen on 7/3/21.
//

import UIKit

/// Assumption is UIViewController class name is given as story board identifier
extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self? {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as? Self
    }
}
