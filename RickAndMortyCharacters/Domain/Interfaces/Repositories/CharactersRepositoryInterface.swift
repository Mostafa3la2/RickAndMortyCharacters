//
//  CharactersRepositoryInterface.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol CharacterRepository {
    func getAllCharacters() -> AnyPublisher<CharactersPage, Error>
}
