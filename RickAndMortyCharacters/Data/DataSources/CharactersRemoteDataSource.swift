//
//  CharactersRemoteDataSource.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol CharactersRemoteDataSource {
    func fetchAllCharacters() -> AnyPublisher<[Character], Error>
}
class DefaultCharactersRemoteDataSource: CharactersRemoteDataSource{
    func fetchAllCharacters() -> AnyPublisher<[Character], Error> {
        // TODO: add the fetch logic
    }
}
