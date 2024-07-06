//
//  Endpoints.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation

struct Endpoints {
    static let baseURL = "https://rickandmortyapi.com/api/"

    static func characters(with parameters: [String: String] = [:]) -> URL? {
        var urlComponents = URLComponents(string: "\(baseURL)/character")
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents?.url
    }
}
