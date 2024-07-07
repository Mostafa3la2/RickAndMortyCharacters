//
//  Colors.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 07/07/2024.
//

import Foundation
import UIKit

// this maps between colors added to assets to be accessed by code
protocol ColorsDesignSystem: RawRepresentable<String> {
    var defaultColor: UIColor { get }
    var Color: UIColor { get }
}
extension ColorsDesignSystem {
    var defaultColor: UIColor {
        return .white
    }
    var Color: UIColor {
        return UIColor(named: self.rawValue) ?? defaultColor
    }
}
extension DesignSystem {
    enum Colors: String, ColorsDesignSystem {
        case BabyBlue
        case ExtraDarkGray
        case MediumGray
        case LightBlue
        case PeachPink
    }
}
