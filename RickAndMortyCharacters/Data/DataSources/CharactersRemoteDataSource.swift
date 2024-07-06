//
//  CharactersRemoteDataSource.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol CharactersRemoteDataSource {
    func fetchAllCharacters() -> AnyPublisher<CharacterResponse, Error>
}
class DefaultCharactersRemoteDataSource: CharactersRemoteDataSource {

    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchAllCharacters() -> AnyPublisher<CharacterResponse, Error> {
        return networkManager.fetchAllCharacters()
    }
}
