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
    @IBOutlet weak var paddedView: UIView!
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
        // assumption: cell color based on status
        self.setCellStyle(basedOn: character.status)
    }
    private func setCellStyle(basedOn status: String?) {
        if let status {
            guard let status = CharacterStatus(rawValue: status) else {
                return
            }
            switch status {
            case .alive:
                self.paddedView.viewBorderWidth = 0
                self.paddedView.backgroundColor = DesignSystem.Colors.LightBlue.Color
            case .dead:
                self.paddedView.viewBorderWidth = 0
                self.paddedView.backgroundColor = DesignSystem.Colors.PeachPink.Color
            case .unknown:
                self.paddedView.viewBorderWidth = 1
                self.paddedView.backgroundColor = .white
            }
        }
    }
}
