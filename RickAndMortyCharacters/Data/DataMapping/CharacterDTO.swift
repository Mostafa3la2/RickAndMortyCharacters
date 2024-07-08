//
//  CharacterDTO.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 07/07/2024.
//

import Foundation

// Data Transfer Object for Characters from API
// MARK: - CharacterPageDTO

struct CharactersPageDTO: Decodable {

    let info: InfoDTO
    let characters: [CharacterDTO]
    private enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
}

struct InfoDTO: Decodable {

    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}


// MARK: - CharacterDTO
struct CharacterDTO: Codable {

    let id: Int?
    let name, status, species, type, gender, image, url, created: String?
    let origin, location: CharacterLocationDTO?
    let episode: [String]?
}

// MARK: - Location
struct CharacterLocationDTO: Codable {
    let name, url: String?
}
extension CharactersPageDTO {
    func toDomain() -> CharactersPage {
        return .init(info: self.info.toDomain(), 
                     characters: self.characters.map{$0.toDomain()})
    }
}
extension CharacterDTO {
    func toDomain() -> Character {
        return .init(id: self.id, 
                     name: self.name,
                     status: self.status,
                     species: self.species,
                     type: self.type, 
                     gender: self.gender,
                     image: self.image,
                     url: self.url,
                     created: self.created,
                     origin: self.origin?.toDomain(),
                     location: self.location?.toDomain(),
                     episode: self.episode)
    }
}
extension CharacterLocationDTO {
    func toDomain() -> CharacterLocation {
        return .init(name: self.name, 
                     url: self.url)
    }
}
extension InfoDTO {
    func toDomain() -> Info {
        return .init(count: self.count, 
                     pages: self.pages,
                     next: self.next,
                     prev: self.prev)
    }
}
