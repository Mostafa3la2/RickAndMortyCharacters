//
//  NetworkManager.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol NetworkManager {
    func fetchAllCharacters() -> AnyPublisher<CharactersPage, Error>
}
class DefaultNetworkManager: NetworkManager {
    private let apiClient = APIClient()

    func fetchAllCharacters() -> AnyPublisher<CharactersPage, Error> {
        guard let url = Endpoints.characters() else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return apiClient.request(url)
    }
}
