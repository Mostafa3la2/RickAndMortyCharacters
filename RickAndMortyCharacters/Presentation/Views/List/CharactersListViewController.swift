//
//  CharactersListViewController.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit

class CharactersListViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet weak var charactersTableView: UITableView!

    // MARK: - Properties
    private let charactersTableViewCellIdentifier = "CharacterTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        setupTableView()
    }

    // MARK: - UI Setup methods
    private func setupTableView() {
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.registerCell(charactersTableViewCellIdentifier)
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: StatusHeaderView = StatusHeaderView.fromNib()
        return headerView
    }
}
