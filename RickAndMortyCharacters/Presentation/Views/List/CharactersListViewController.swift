//
//  CharactersListViewController.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit
import Combine

class CharactersListViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet weak var charactersTableView: UITableView!

    // MARK: - Properties
    private let charactersTableViewCellIdentifier = "CharacterTableViewCell"
    private var viewModel: CharactersListViewModel?
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        setupTableView()
        setupBindings()
        viewModel?.fetchCharacters()
    }
    func setupViewModel(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - UI Setup methods
    private func setupTableView() {
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.registerCell(charactersTableViewCellIdentifier)
        charactersTableView.showsVerticalScrollIndicator = false
    }

    private func setupBindings() {
        viewModel?.$characterItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.charactersTableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel?.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    // Handle error (e.g., show an alert)
                    // TODO: show SwiftUI Alert ?
                    print("Error: \(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)
    }
}
// MARK: - Tableview delegate methods
extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characterItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: charactersTableViewCellIdentifier) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        if let character = viewModel?.characterItems[indexPath.row] {
            cell.setCharacterData(character: character)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: StatusHeaderView = StatusHeaderView.fromNib()
        return headerView
    }
}
