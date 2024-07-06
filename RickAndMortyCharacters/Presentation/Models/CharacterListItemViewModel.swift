//
//  CharacterListItemViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation

struct CharacterListItemViewModel {
    let name, image, species, status: String?

    init(character: Character) {
        self.name = character.name
        self.image = character.image
        self.species = character.species
        self.status = character.status
    }
}
