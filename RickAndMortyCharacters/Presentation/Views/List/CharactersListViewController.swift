//
//  CharactersListViewController.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit

class CharactersListViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet weak var statusCollectionView: UICollectionView!
    @IBOutlet weak var charactersTableView: UITableView!

    // MARK: - Properties
    private let charactersTableViewCellIdentifier = "CharacterTableViewCell"
    private let statusCollectionViewCellIdentifier = "CharacterStatusCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        setupTableView()
        setupCollectionView()
    }

    // MARK: - UI Setup methods
    private func setupTableView() {
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.registerCell(charactersTableViewCellIdentifier)
    }
    private func setupCollectionView() {
        statusCollectionView.delegate = self
        statusCollectionView.dataSource = self
        statusCollectionView.registerCell(statusCollectionViewCellIdentifier)
    }
}
// MARK: - Tableview delegate methods
extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: charactersTableViewCellIdentifier) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }

}
// MARK: - Collectionview delegate methods
extension CharactersListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

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
