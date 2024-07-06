//
//  CharactersRepositoryInterface.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol CharacterRepository {
    func getAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<CharactersPage, Error>
}
