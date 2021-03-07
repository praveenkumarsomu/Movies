//
//  Registable.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

protocol Registrable: class {
    static func reuseIdentifier() -> String
    static func nib() -> UINib
}
