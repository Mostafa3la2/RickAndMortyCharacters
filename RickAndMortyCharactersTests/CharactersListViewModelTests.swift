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
    private var networkManager: DefaultNetworkManager!
    private var dataSource: CharactersRemoteDataSource!
    private var repository: CharacterRepository!
    private var useCase: FetchAllCharactersUseCase!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkManager = TestDIContainer.shared.makeMockNetworkManager()
        networkManager = DefaultNetworkManager()
        dataSource = TestDIContainer.shared.makeDefaultCharacterDataSource(networkManager: mockNetworkManager)
        repository = TestDIContainer.shared.makeCharacterRepository(dataSource: dataSource)
        useCase = TestDIContainer.shared.makeFetchAllCharactersUseCase(repo: repository)
        viewModel = TestDIContainer.shared.makeCharacterListViewModel(usecase: useCase)
        cancellables = []
    }
    override func tearDown() {
        viewModel = nil
        dataSource = nil
        networkManager = nil
        useCase = nil
        repository = nil
        mockNetworkManager = nil
        cancellables = nil
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
    func testAPIFetchCharactersSuccessfully() {
        // Arrange
        let expectedCharacters = [Character(id: 1,
                                           name: "Rick",
                                           status: "alive",
                                           species: "Human",
                                           type: "",
                                           gender: "Male",
                                           image: "",
                                           url: "",
                                           created: "",
                                           origin: nil,
                                           location: nil,
                                           episode: nil),
                                  Character(id: 2,
                                            name: "Morty",
                                            status: "alive",
                                            species: "Human",
                                            type: "",
                                            gender: "Male",
                                            image: "",
                                            url: "",
                                            created: "",
                                            origin: nil,
                                            location: nil,
                                            episode: nil)
                                    ]
        let apiCharactersDTO = [CharacterDTO(id: 1,
                                          name: "Rick",
                                          status: "alive",
                                          species: "Human",
                                          type: "",
                                          gender: "Male",
                                          image: "",
                                          url: "",
                                          created: "",
                                          origin: nil,
                                          location: nil,
                                          episode: nil),
                                CharacterDTO(id: 2,
                                           name: "Morty",
                                           status: "alive",
                                           species: "Human",
                                           type: "",
                                           gender: "Male",
                                           image: "",
                                           url: "",
                                           created: "",
                                           origin: nil,
                                           location: nil,
                                           episode: nil)
                                   ]
        let apiResponseDTO = CharactersPageDTO(info: InfoDTO(count: 4, pages: 4, next: nil, prev: nil), characters: apiCharactersDTO)
        mockNetworkManager.fetchCharactersResult = Just((apiResponseDTO, URLResponse()))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let expectation = expectation(description: "Characters fetched and mapped successfully")
        // Act
        viewModel.fetchCharacters(resetPage: true)
        expectation.fulfill()

        // Assert
        XCTAssertEqual(viewModel.charactersListItems.first?.name, expectedCharacters.first?.name)

        self.wait(for: [expectation], timeout: 1)
    }

    func testAPIIntegration() {
        dataSource = DefaultCharactersRemoteDataSource(networkManager: networkManager)
         let expectation = expectation(description: "Test Remote API up and running")

        networkManager.fetchAllCharacters(withParameters: [:])
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            } receiveValue: { data, response in
                if let httpResponse = response as? HTTPURLResponse {
                    XCTAssertEqual(httpResponse.statusCode, 200, "Expected HTTP status code 200")
                    expectation.fulfill()
                } else {
                    XCTFail("invalid response received")
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10)
    }
}
