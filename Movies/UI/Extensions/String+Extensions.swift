//
//  String+Extensions.swift
//  Movies
//
//  Created by Praveen on 7/3/21.
//

import Foundation

extension String {
    /// Convert string into url converable
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
}
