//
//  CharactersListViewModelTests.swift
//  RickAndMortyCharactersTests
//
//  Created by Mostafa Alaa on 07/07/2024.
//

import XCTest
import Combine
@testable import RickAndMortyCharacters

final class CharactersListViewModelTests: XCTestCase {

    private var viewModel: CharactersListViewModel!
    private var mockRepo: MockCharacterRepository!
    private var fetchAllCharactersUseCase: DefaultFetchAllCharactersUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepo = TestDIContainer.shared.makeMockCharacterRepository()
        fetchAllCharactersUseCase = TestDIContainer.shared.makeFetchAllCharactersUseCase(repository: mockRepo)
        viewModel = TestDIContainer.shared.makeCharacterListViewModel(useCase: fetchAllCharactersUseCase)
        cancellables = []
    }
    override func tearDown() {
        viewModel = nil
        mockRepo = nil
        fetchAllCharactersUseCase = nil
        cancellables = nil
        super.tearDown()
    }
}
