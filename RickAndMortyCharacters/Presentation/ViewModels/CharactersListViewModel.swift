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
    @Published private(set) var loading: Bool = false
    private var currentPage = 1
    private var canLoadMorePages = true
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods
    init(fetchCharactersUseCase: FetchAllCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
        // self.filterCharactersUseCase = filterCharactersUseCase
    }

    func fetchCharacters(resetPage: Bool = false) {
        if resetPage {
            currentPage = 1
            canLoadMorePages = true
            charactersPage = nil
            characterItems = []
        }
        guard canLoadMorePages else {
            return
        }
        loading = true
        let parameters = ["page": "\(currentPage)"]
        fetchCharactersUseCase.execute(parameters: parameters)
            .sink { completion in
                self.loading = false
                switch completion {
                case .failure(let error):
                    self.error = error
                    print("error is \(error)")
                case .finished:
                    break
                }
            } receiveValue: { charactersPage in
                self.charactersPage = charactersPage
                self.characterItems.append(contentsOf: charactersPage.results.map(CharacterListItemViewModel.init))
                self.currentPage += 1
                self.canLoadMorePages = charactersPage.info.next != nil
            }
            .store(in: &cancellables)
    }
    func fetchNextPage() {
        fetchCharacters()
    }
//    func filterCharacters(by criteria: (Character) -> Bool) {
//        self.filteredCharacters = filterCharactersUseCase.execute(characters: characters, criteria: criteria)
//    }
}
