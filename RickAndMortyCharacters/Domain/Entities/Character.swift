//
//  Character.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation

// MARK: - Characters Page

struct CharactersPage {
    let info: Info
    let characters: [Character]
}

struct Info {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Character
struct Character {
    let id: Int?
    let name, status, species, type, gender, image, url, created: String?
    let origin, location: CharacterLocation?
    let episode: [String]?
}

// MARK: - Location
struct CharacterLocation {
    let name, url: String?
}
