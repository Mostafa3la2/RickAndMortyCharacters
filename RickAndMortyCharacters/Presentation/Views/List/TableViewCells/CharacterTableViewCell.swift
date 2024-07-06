//
//  CharacterTableViewCell.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit
import Kingfisher
class CharacterTableViewCell: UITableViewCell {

    // MARK: - UI Outlets
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCharacterData(character: CharacterListItemViewModel) {
        self.characterNameLabel.text = character.name
        self.characterSpeciesLabel.text = character.species
        if let url = URL(string: character.image ?? "") {
            self.characterImageView.kf.setImage(with: url)
        }
    }
}
