//
//  CharacterStatusCollectionViewCell.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit

class CharacterStatusCollectionViewCell: UICollectionViewCell {

    // MARK: - UI Outlets
    @IBOutlet weak var characterStatusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewCornerRadius = self.frame.height/2
        // Initialization code
    }

    // MARK: - Methods
    func setStatusData(status: CharacterStatus) {
        self.characterStatusLabel.text = status.rawValue
    }
}
