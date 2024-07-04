//
//  StatusHeaderView.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit

class StatusHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var statusCollectionView: UICollectionView!
    private let statusCollectionViewCellIdentifier = "CharacterStatusCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        setupHeaderView()
        setupCollectionView()
    }
    private func setupCollectionView() {
        statusCollectionView.delegate = self
        statusCollectionView.dataSource = self
        statusCollectionView.registerCell(statusCollectionViewCellIdentifier)
    }
    private func setupHeaderView(){
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        self.backgroundView = backgroundView
    }
}
// MARK: - Collectionview delegate methods
extension StatusHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: statusCollectionViewCellIdentifier, for: indexPath) as? CharacterStatusCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
