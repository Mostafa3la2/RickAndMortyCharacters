//
//  UIView+Extensions.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit

extension UIView {

    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var viewBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
