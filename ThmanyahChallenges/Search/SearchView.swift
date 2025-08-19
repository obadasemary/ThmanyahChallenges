//
//  SearchView.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import UIKit
import SwiftUI
import ThmanyahUseCase

// MARK: - UIKit SearchView
final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: SearchViewModel
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let emptyStateLabel = UILabel()
    
    // MARK: - Initialization
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupSearchController()
        setupTableView()
        setupEmptyState()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(emptyStateLabel)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            emptyStateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search podcasts, episodes, audiobooks..."
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.keyboardDismissMode = .interactive
    }
    
    private func setupEmptyState() {
        emptyStateLabel.text = "Search for podcasts, episodes, audiobooks, and articles"
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .secondaryLabel
        emptyStateLabel.font = .systemFont(ofSize: 16)
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.isHidden = false
    }
    
    private func setupBindings() {
        // For @Observable, we need to observe the properties directly
        // Since we can't use objectWillChange, we'll update UI in the search method
    }
    
    // MARK: - UI Updates
    private func updateUI() {
        loadingIndicator.isHidden = !viewModel.isLoading
        emptyStateLabel.isHidden = !viewModel.results.isEmpty || viewModel.isLoading
        
        if viewModel.isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
        
        tableView.reloadData()
    }
    
    private func performSearch(with term: String) {
        Task {
            await viewModel.search(term: term)
            // Update UI after search completes
            await MainActor.run {
                updateUI()
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchTerm = searchController.searchBar.text, !searchTerm.isEmpty else {
            return
        }
        
        // Debounce search
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performDelayedSearch), object: nil)
        perform(#selector(performDelayedSearch), with: searchTerm, afterDelay: 0.5)
    }
    
    @objc private func performDelayedSearch(_ searchTerm: String) {
        performSearch(with: searchTerm)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        performSearch(with: searchTerm)
        searchController.isActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Clear results when cancel is tapped
        Task {
            await viewModel.search(term: "")
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as! SearchResultCell
        let result = viewModel.results[indexPath.row]
        cell.configure(with: result)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Height for TwoLinesCard design
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = viewModel.results[indexPath.row]
        // Handle selection - could navigate to detail view
        print("Selected: \(result)")
    }
}

// MARK: - SwiftUI Wrapper
struct SearchView: View {
    let viewModel: SearchViewModel
    
    var body: some View {
        SearchViewControllerRepresentable(viewModel: viewModel)
    }
}

// MARK: - UIViewControllerRepresentable
struct SearchViewControllerRepresentable: UIViewControllerRepresentable {
    let viewModel: SearchViewModel
    
    func makeUIViewController(context: Context) -> SearchViewController {
        return SearchViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) {
        // Update if needed
    }
}

// MARK: - Preview Helper
#if DEBUG
extension SearchView {
    static func preview() -> SearchView {
        let viewModel = SearchViewModel(searchUseCase: PreviewSearchUseCase())
        return SearchView(viewModel: viewModel)
    }
}

private final class PreviewSearchUseCase: SearchUseCaseProtocol {
    func execute(term: String) async throws -> SearchResponse {
        return SearchResponse(results: [])
    }
}
#endif
