//
//  CharacterRepository.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

class DefaultCharacterRepository: CharacterRepository {

    private let remoteDataSource: CharactersRemoteDataSource

    init(remoteDataSource: CharactersRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<CharactersPage, Error> {
        return remoteDataSource.fetchAllCharacters(withParameters: parameters)
    }
    func filterCharacters(withParameters parameters: [String: String]) -> AnyPublisher<CharactersPage, Error> {
        return remoteDataSource.fetchAllCharacters(withParameters: parameters)
    }
}
