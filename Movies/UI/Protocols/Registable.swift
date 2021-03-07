//
//  Registable.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

/// Protocol to the Register `UICollectionView` and `UITableView` cells
protocol Registrable: class {
    static func reuseIdentifier() -> String
    static func nib() -> UINib
}
