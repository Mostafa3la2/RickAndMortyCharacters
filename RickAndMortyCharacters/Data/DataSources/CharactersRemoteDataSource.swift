//
//  CharactersRemoteDataSource.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol CharactersRemoteDataSource {
    func fetchAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<CharactersPage, Error>
}
class DefaultCharactersRemoteDataSource: CharactersRemoteDataSource {

    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<CharactersPage, Error> {
        return networkManager.fetchAllCharacters(withParameters: parameters)
            .map{ characterDTO in
                characterDTO.toDomain()
            }
            .eraseToAnyPublisher()
    }
}
