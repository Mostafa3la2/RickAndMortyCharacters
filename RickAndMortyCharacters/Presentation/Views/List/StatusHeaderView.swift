//
//  StatusHeaderView.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit

class StatusHeaderView: UITableViewHeaderFooterView {
    // MARK: - IBOutlet
    @IBOutlet weak var statusCollectionView: UICollectionView!

    // MARK: - Properties
    private let statusCollectionViewCellIdentifier = "CharacterStatusCollectionViewCell"
    private var viewModel: CharactersListViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupHeaderView()
        setupCollectionView()
    }

    func injectViewModel(viewModel: CharactersListViewModel?) {
        self.viewModel = viewModel
        self.statusCollectionView.reloadData()
    }
    private func setupCollectionView() {
        statusCollectionView.delegate = self
        statusCollectionView.dataSource = self
        statusCollectionView.registerCell(statusCollectionViewCellIdentifier)
        statusCollectionView.showsHorizontalScrollIndicator = false
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
        return viewModel?.statusFilter.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: statusCollectionViewCellIdentifier, for: indexPath) as? CharacterStatusCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let status = viewModel?.statusFilter[indexPath.row] {
            cell.setStatusData(status: status)
        }
        return cell
    }
}
