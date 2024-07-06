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
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        setupTableView()
        setupBindings()
        viewModel?.fetchCharacters(resetPage: true)
    }
    func injectViewModel(viewModel: CharactersListViewModel) {
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

        viewModel?.$loading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                } else {
                    self?.loadingIndicator.stopAnimating()
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
        headerView.injectViewModel(viewModel: self.viewModel)
        return headerView
    }

    // MARK: Pagination Logic
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height && viewModel?.loading == false {
            viewModel?.fetchNextPage()
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return loadingIndicator
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
