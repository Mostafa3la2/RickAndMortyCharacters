//
//  Character.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation

// MARK: - Character
struct Character: Codable {
    let id: Int?
    let name, status, species, type, gender, image, url, created: String?
    let origin, location: CharacterLocation?
    let episode: [String]?
}

// MARK: - Location
struct CharacterLocation: Codable {
    let name, url: String?
}
