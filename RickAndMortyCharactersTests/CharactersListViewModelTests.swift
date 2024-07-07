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
    private var mockNetworkManager: MockNetworkManager!
    private var dataSource: CharactersRemoteDataSource!
    private var repository: CharacterRepository!
    private var useCase: FetchAllCharactersUseCase!

    override func setUp() {
        super.setUp()
        mockNetworkManager = TestDIContainer.shared.makeMockNetworkManager()
        dataSource = TestDIContainer.shared.makeDefaultCharacterDataSource(networkManager: mockNetworkManager)
        repository = TestDIContainer.shared.makeCharacterRepository(dataSource: dataSource)
        useCase = TestDIContainer.shared.makeFetchAllCharactersUseCase(repo: repository)
        viewModel = TestDIContainer.shared.makeCharacterListViewModel(usecase: useCase)
    }
    override func tearDown() {
        viewModel = nil
        dataSource = nil
        useCase = nil
        repository = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testAPICallFail() {
        // Arrange
        let expectedError = URLError(.networkConnectionLost)
        mockNetworkManager.fetchCharactersResult = Fail(error: expectedError)
            .eraseToAnyPublisher()
        let expectation = expectation(description: "API serivce failure")
        // Act
        viewModel.fetchCharacters(resetPage: true)
        expectation.fulfill()

        // Assert
        XCTAssertEqual(viewModel.error as? URLError, expectedError)

        self.wait(for: [expectation], timeout: 1)
    }
}
