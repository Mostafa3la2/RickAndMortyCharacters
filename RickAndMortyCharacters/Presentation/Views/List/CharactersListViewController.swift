//
//  CharactersListViewController.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 05/07/2024.
//

import UIKit
import Combine
import SkeletonView

class CharactersListViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet weak var charactersTableView: UITableView!

    // MARK: - Properties
    private let charactersTableViewCellIdentifier = "CharacterTableViewCell"
    private var viewModel: CharactersListViewModel?
    private var cancellables = Set<AnyCancellable>()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let refreshIndicator = UIRefreshControl()
    private var coordinator: CharacterCoordinatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        setupTableView()
        setupBindings()
        charactersTableView.showAnimatedSkeleton()
        viewModel?.fetchCharacters(resetPage: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ensure navigation bar visibility restoration after being hidden in details page
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func injectData(viewModel: CharactersListViewModel, coordinator: CharacterCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }

    // MARK: - UI Setup methods
    private func setupTableView() {
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.registerCell(charactersTableViewCellIdentifier)
        charactersTableView.showsVerticalScrollIndicator = false
        refreshIndicator.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        charactersTableView.refreshControl = refreshIndicator
    }

    private func setupBindings() {
        viewModel?.$characterItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                if self?.refreshIndicator.isRefreshing == true {
                    self?.refreshIndicator.endRefreshing()
                }
                self?.charactersTableView.hideSkeleton()
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
    @objc func pullToRefresh() {
        viewModel?.fetchCharacters(resetPage: true)
    }
}
// MARK: - Tableview delegate methods
extension CharactersListViewController: UITableViewDelegate, SkeletonTableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characterItems.count ?? 0
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characterDetails = viewModel?.getCharacterDetails(atIndex: indexPath.row) else {
            return
        }
        coordinator?.showCharacterDetails(characterDetail: characterDetails)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: StatusHeaderView = StatusHeaderView.fromNib()
        headerView.injectViewModel(viewModel: self.viewModel)
        return headerView
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return charactersTableViewCellIdentifier
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
