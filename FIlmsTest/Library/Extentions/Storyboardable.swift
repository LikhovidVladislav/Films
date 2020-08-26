//
//  Storyboardable.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 17.06.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboardable: class {
    static var storyboardName: String { get }
}

extension Storyboardable where Self: UIViewController {

    static func storyboardViewController() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
             fatalError("Could not instantiate initial storyboard with name: \(storyboardName)")
        }
        
        return vc
    }
}
