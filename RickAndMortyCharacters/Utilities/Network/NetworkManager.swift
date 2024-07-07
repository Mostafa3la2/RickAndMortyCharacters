//
//  NetworkManager.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol NetworkManager {
    func fetchAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<(data: CharactersPageDTO, response: URLResponse), Error>
}
class DefaultNetworkManager: NetworkManager {
    private let apiClient = APIClient()

    func fetchAllCharacters(withParameters parameters: [String: String]) -> AnyPublisher<(data: CharactersPageDTO, response: URLResponse), Error> {
        guard let url = Endpoints.characters(with: parameters) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return apiClient.request(url)
    }
}
