//
//  CollectionViewCell+Extension.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

extension Registrable where Self: UICollectionViewCell {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    static func nib() -> UINib {
        return UINib(nibName: self.reuseIdentifier(), bundle: Bundle(for: self.classForCoder()))
    }
}

