//
//  extension+UITableViewCell.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 31/10/21.
//

import UIKit

extension UITableViewCell {
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier:String {
        return String(describing: self)
    }
}
