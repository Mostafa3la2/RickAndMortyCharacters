//
//  UITableView+Extensions.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit

extension UITableView {
    func registerCell(_ identifierName: String) {
        self.register(UINib(nibName: identifierName, bundle: nil), forCellReuseIdentifier: identifierName)
    }
}
