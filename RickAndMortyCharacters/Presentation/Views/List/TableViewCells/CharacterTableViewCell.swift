//
//  CharacterTableViewCell.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - UI Outlets
    @IBOutlet weak var characterSpeciesLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCharacterData() {
        // TODO: pass character model and set ui data
    }
}
