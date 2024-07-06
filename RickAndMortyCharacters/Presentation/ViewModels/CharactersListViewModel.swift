//
//  CharactersListViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

class CharactersListViewModel: ObservableObject {

    // MARK: - Properties
    private let fetchCharactersUseCase: FetchAllCharactersUseCase
    // private let filterCharactersUseCase: FilterCharactersUseCase
    private var charactersPage: CharactersPage?
    private var filteredCharacters: [Character] = []
    @Published var characterItems: [CharacterListItemViewModel] = []
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods
    init(fetchCharactersUseCase: FetchAllCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
        // self.filterCharactersUseCase = filterCharactersUseCase
    }

    func fetchCharacters() {
        fetchCharactersUseCase.execute()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                    print("error is \(error)")
                case .finished:
                    break
                }
            } receiveValue: { charactersPage in
                self.charactersPage = charactersPage
                self.characterItems = charactersPage.results.map(CharacterListItemViewModel.init)
            }
            .store(in: &cancellables)
    }

//    func filterCharacters(by criteria: (Character) -> Bool) {
//        self.filteredCharacters = filterCharactersUseCase.execute(characters: characters, criteria: criteria)
//    }
}
