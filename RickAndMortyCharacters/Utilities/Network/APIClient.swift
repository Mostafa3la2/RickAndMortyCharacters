//
//  APIClient.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

class APIClient {
    func request<T: Decodable>(_ url: URL, method: HTTPMethod = .get) -> AnyPublisher<(data: T, response: URLResponse), Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return (data, response)
            }
            .flatMap{ (data, response) in
                Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .map { decodedData in
                        return (data: decodedData, response: response)}
                    .mapError{$0 as Error}
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
