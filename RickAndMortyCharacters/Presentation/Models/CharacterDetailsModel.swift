//
//  CharacterDetailsModel.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 07/07/2024.
//

import Foundation
struct CharacterDetailsModel {

    let name, image, species, gender, location, status: String?

    init(character: Character) {
        self.name = character.name
        self.image = character.image
        self.species = character.species
        self.status = character.status
        self.gender = character.gender
        self.location = character.location?.name
    }

    init(name: String?, image: String?, species: String?, gender: String?, location: String, status: String?) {
        self.name = name
        self.image = image
        self.species = species
        self.status = status
        self.gender = gender
        self.location = location
    }
}
