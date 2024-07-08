//
//  CharacterDetailsView.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 06/07/2024.
//

import SwiftUI
import Kingfisher

struct CharacterDetailsView: View {

    // MARK: - Properties
    var characterDetails: CharacterDetailsModel

    // MARK: - View
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading,  spacing: 24) {
                        ImageHeaderView(geometry: geometry, image: characterDetails.image)
                        VStack(alignment: .leading) {
                            HStack {
                                CharacterNameLabel(name: characterDetails.name)
                                Spacer()
                                CharacterStatusLabel(status: characterDetails.status)
                            }
                            HStack {
                                CharacterSpeciesLabel(species: characterDetails.species)
                                Text(" • ")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                CharacterGenderLabel(gender: characterDetails.gender)
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        CharacterLocationLabel(location: characterDetails.location)
                            .padding(.leading, 16)
                    }
                    NavigationBackButton()
                }
                .toolbar(.hidden, for: .navigationBar)
            }
    }
}

#Preview {
    let characterDetails = CharacterDetailsModel(
        name: "Test",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        species: "Human",
        gender: "Male",
        location: "Earth C-137",
        status: "Alive")
    return CharacterDetailsView(characterDetails: characterDetails)
}

struct ImageHeaderView: View {

    // MARK: - Properties
    var geometry: GeometryProxy!
    var imageURL: String?

    // MARK: - Initializer
    init(geometry: GeometryProxy!, image: String?) {
        self.geometry = geometry
        self.imageURL = image
    }

    // MARK: - View
    var body: some View {
        KFImage(URL(string: imageURL ?? ""))
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.width-50)
            .clipShape(.rect(
                bottomLeadingRadius: 40,
                bottomTrailingRadius: 40
            ))
    }
}
struct CharacterNameLabel: View {

    // MARK: - Properties
    var name: String?

    // MARK: - Initializer
    init(name: String?) {
        self.name = name
    }

    // MARK: - View
    var body: some View {
        Text(name ?? "")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .lineLimit(2)
    }
}
struct CharacterSpeciesLabel: View {

    // MARK: - Properties
    var species: String?

    // MARK: - Initializer
    init(species: String?) {
        self.species = species
    }
    // MARK: - View
    var body: some View {
        Text(species ?? "")
            .font(.title3)
            .foregroundStyle(Color(DesignSystem.Colors.ExtraDarkGray.Color))
    }
}
struct CharacterStatusLabel: View {

    // MARK: - Properties
    var status: String?

    // MARK: - Initializer
    init(status: String?) {
        self.status = status
    }

    // MARK: - View
    var body: some View {
        Text(status ?? "")
            .padding(.all, 8)
            .background(Color(DesignSystem.Colors.BabyBlue.Color))
            .clipShape(.capsule)
    }
}
struct CharacterGenderLabel: View {

    // MARK: - Properties
    var gender: String?

    // MARK: - Initializer
    init(gender: String?) {
        self.gender = gender
    }

    // MARK: - View
    var body: some View {
        Text(gender ?? "")
            .font(.title3)
            .foregroundStyle(Color(DesignSystem.Colors.MediumGray.Color))
    }
}
struct CharacterLocationLabel: View {

    // MARK: - Properties
    var location: String?

    // MARK: - Initializer
    init(location: String?) {
        self.location = location
    }

    // MARK: - View
    var body: some View {
        HStack {
            Text("Location: ")
                .font(.title2)
                .fontWeight(.bold)
            Text(location ?? "")
                .foregroundStyle(Color(DesignSystem.Colors.ExtraDarkGray.Color))
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}
struct NavigationBackButton: View {

    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode

    // MARK: - View
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
                .padding(16)
                .background(Circle().fill(.white))
                .padding(.top, 40)
                .padding(.leading, 24)
                .shadow(radius: 2)
        }
        .accessibilityIdentifier("back")
    }
}
