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
    private let searchBar = UISearchBar()
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
        setupSearchBar()
        setupTableView()
        setupEmptyState()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        
        // Set the back button and navigation bar tint color to match HomeFeedView accent
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Search"
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(emptyStateLabel)
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                // Search bar at top under safe area
                searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                // Table below search bar
                tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                emptyStateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
                emptyStateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
            ]
        )
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Search podcasts, episodes, audiobooks..."
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
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
        // For @Observable, we update UI after actions complete
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
            await MainActor.run { self.updateUI() }
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(_debouncedSearch(_:)), object: nil)
        perform(#selector(_debouncedSearch(_:)), with: searchText, afterDelay: 0.2)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        performSearch(with: text)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        performSearch(with: "")
    }
    
    @objc private func _debouncedSearch(_ text: NSString) {
        let term = String(text)
        guard !term.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        performSearch(with: term)
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
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = viewModel.results[indexPath.row]
        print("Selected: \(result)")
    }
}

// MARK: - SwiftUI Wrapper
struct SearchView: View {
    let viewModel: SearchViewModel
    
    var body: some View {
        SearchViewControllerRepresentable(viewModel: viewModel)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let viewModel = SearchViewModel(searchUseCase: PreviewSearchUseCase())
    return SearchView(viewModel: viewModel)
}

// MARK: - UIViewControllerRepresentable
struct SearchViewControllerRepresentable: UIViewControllerRepresentable {
    let viewModel: SearchViewModel
    
    func makeUIViewController(context: Context) -> SearchViewController {
        SearchViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: SearchViewController, context: Context) { }
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
