//
//  FilterCharactersUseCase.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation

protocol FilterCharactersUseCase {
    func execute(characters: [Character], criteria: (Character) -> Bool) -> [Character]
}

final class DefaultFilterCharactersUseCase: FilterCharactersUseCase {
    func execute(characters: [Character], criteria: (Character) -> Bool) -> [Character] {
        return characters.filter(criteria)
    }
}
