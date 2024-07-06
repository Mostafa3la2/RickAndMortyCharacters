//
//  CharactersListViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

protocol CharactersListViewModel {
    func fetchCharacters()
    func filterCharacters(by criteria: (Character) -> Bool)
}
class DefaultCharactersListViewModel: ObservableObject, CharactersListViewModel {

    // MARK: - Properties
    private let fetchCharactersUseCase: FetchAllCharactersUseCase
    private let filterCharactersUseCase: FilterCharactersUseCase
    @Published var characters: [Character] = []
    @Published var filteredCharacters: [Character] = []
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods
    init(fetchCharactersUseCase: FetchAllCharactersUseCase, filterCharactersUseCase: FilterCharactersUseCase, characters: [Character]) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
        self.filterCharactersUseCase = filterCharactersUseCase
    }

    func fetchCharacters() {
        fetchCharactersUseCase.execute()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            } receiveValue: { characters in
                self.characters = characters
            }
            .store(in: &cancellables)
    }

    func filterCharacters(by criteria: (Character) -> Bool) {
        self.filteredCharacters = filterCharactersUseCase.execute(characters: characters, criteria: criteria)
    }
}
