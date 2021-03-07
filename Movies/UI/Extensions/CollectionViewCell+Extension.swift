//
//  CollectionViewCell+Extension.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

extension Registrable where Self: UICollectionViewCell {
    /// Gets the reuse identifier to the `UICollectionViewCell` cell
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    /// Gets the nib for the `UICollectionViewCell` cell
    static func nib() -> UINib {
        return UINib(nibName: self.reuseIdentifier(), bundle: Bundle(for: self.classForCoder()))
    }
}

