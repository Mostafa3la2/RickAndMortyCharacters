//
//  NetworkManager.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol NetworkManager {
    func fetchAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<CharactersPageDTO, Error>
}
class DefaultNetworkManager: NetworkManager {
    private let apiClient = APIClient()

    func fetchAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<CharactersPageDTO, Error> {
        guard let url = Endpoints.characters(with: parameters) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return apiClient.request(url)
    }
}
