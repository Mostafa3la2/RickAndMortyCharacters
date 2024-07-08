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
    func testPagination() {
        let mockRepo = MockCharacterRepository()
        useCase = DefaultFetchAllCharactersUseCase(charactersRepository: mockRepo)
        viewModel = CharactersListViewModel(fetchCharactersUseCase: useCase)
        let firstPageCharacters = [Character(id: 1,
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
        let secondPageCharacters = [Character(id: 3,
                                          name: "Beth",
                                          status: "alive",
                                          species: "Human",
                                          type: "",
                                          gender: "Female",
                                          image: "",
                                          url: "",
                                          created: "",
                                          origin: nil,
                                          location: nil,
                                           episode: nil),
                                Character(id: 4,
                                           name: "Jerry",
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
        let firstPage = CharactersPage(info: Info(count: 2, pages: 5, next: "nextPage", prev: nil), characters: firstPageCharacters)
        let secondPage = CharactersPage(info: Info(count: 2, pages: 5, next: nil, prev: "prevPage"), characters: secondPageCharacters)

        let expectation = expectation(description: "Fetching paginated characters succeeds")
        mockRepo.fetchAllCharactersResult = .success(firstPage)
        viewModel.$charactersListItems
            .dropFirst(2) // Dropping the initial empty array and the reset page logic
            .sink{ characters in
                if characters.count == firstPageCharacters.count {
                    XCTAssertEqual(characters.count, firstPageCharacters.count)
                    XCTAssertEqual(characters.first?.name, firstPageCharacters.first?.name)
                    XCTAssertEqual(characters.last?.name, firstPageCharacters.last?.name)
                } else if characters.count == firstPageCharacters.count + secondPageCharacters.count {
                    XCTAssertEqual(characters.count, firstPageCharacters.count + secondPageCharacters.count)
                    XCTAssertEqual(characters.first?.name, firstPageCharacters.first?.name)
                    XCTAssertEqual(characters.last?.name, secondPageCharacters.last?.name)
                    expectation.fulfill()
                } else {
                    XCTFail("unexpected number of characters: \(characters.count)")
                }
            }
            .store(in: &cancellables)

        viewModel.fetchCharacters(resetPage: true)
        mockRepo.fetchAllCharactersResult = .success(secondPage)
        self.viewModel.fetchNextPage()
        wait(for: [expectation], timeout: 2.0)
    }
}
