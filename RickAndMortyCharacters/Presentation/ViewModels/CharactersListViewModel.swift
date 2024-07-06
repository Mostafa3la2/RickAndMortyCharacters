//
//  CharactersListViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import Foundation
import Combine

enum CharacterStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
class CharactersListViewModel: ObservableObject {

    // MARK: - Properties
    private let fetchCharactersUseCase: FetchAllCharactersUseCase
    private var charactersPage: CharactersPage?
    private var filteredCharacters: [Character] = []

    @Published var characterItems: [CharacterListItemViewModel] = []
    @Published var error: Error?
    @Published private(set) var loading: Bool = false
    private var currentPage = 1
    private var canLoadMorePages = true
    private var cancellables = Set<AnyCancellable>()
    var statusFilter = [CharacterStatus.alive, .dead, .unknown]
    var selectedFilterIndex = -1
    // MARK: - Methods
    init(fetchCharactersUseCase: FetchAllCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }

    func fetchCharacters(resetPage: Bool = false, filter: [String: String] = [:]) {
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
        var parameters = ["page": "\(currentPage)"]
        if !filter.isEmpty {
            parameters.merge(filter) { (current, _) in current }
        }
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
    func filterCharacters(filterType: String = "status", filterValue: String) {
        selectedFilterIndex = statusFilter.firstIndex{$0.rawValue == filterValue} ?? -1
        self.fetchCharacters(resetPage: true, filter: [filterType: filterValue])
    }
}
