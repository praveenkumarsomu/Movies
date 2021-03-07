//
//  StoryBoarded.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit
/// Initiate UIViewController from the story board
protocol Storyboarded {
    static func instantiate() -> Self?
}
