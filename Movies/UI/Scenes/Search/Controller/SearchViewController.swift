//
//  ViewController.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import UIKit

/// Search view controller is Initial view controller for application
class SearchViewController: UIViewController, Storyboarded {
    /// Collection view data source
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Movie>
    /// Collection view snap shot
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Movie>
    /// Collection view section types
    enum Section {
      case main
    }
    /// Coordinator instance for navigation
    weak var coordinator: MainCoordinator?
    /// View model of type `SearchViewModel`
    var viewModel: SearchViewModel!
    // MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK:- Private variables
    private(set) var searchController = UISearchController(searchResultsController: nil)
    private lazy var dataSource = makeDataSource()
    private(set) var showPaginationLoader = false
    private var searchKeyWord: String {
        return searchController.searchBar.text ?? ""
    }
    // MARK:- View controller life cycyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = searchContainer.resolve(SearchViewModel?.self) {
            self.viewModel = viewModel
        }
        configureSearchController()
        configireCollectionViewLayout()
        bindViewModel()
    }
    // MARK:- Collection view data source
    func makeDataSource() -> DataSource {
      let dataSource = DataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, movie) ->
          UICollectionViewCell? in
          // 2
          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier(),
            for: indexPath) as? MovieCollectionViewCell
            cell?.movie = movie
          return cell
      })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
          guard kind == UICollectionView.elementKindSectionFooter else {
            return nil
          }
          let _ = self.dataSource.snapshot()
            .sectionIdentifiers[indexPath.section]
          let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FooterLoaderCollectionReusableView.reuseIdentifier(),
            for: indexPath) as? FooterLoaderCollectionReusableView
            view?.loading = true
          return view
        }
      return dataSource
    }
    func applySnapshot(with animation: Bool = true) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.movies)
        dataSource.apply(snapshot, animatingDifferences: animation)
        collectionView.backgroundView = getEmptyPlaceholderView()
    }
    // MARK:- Private functions
    /// Bind view model output to update search status
    private func bindViewModel() {
        viewModel.receiveErrorFromSearchMovies = { [weak self] error in
            guard let self = self else { return }
            self.showPaginationLoader = false
            self.showErrorMessage(with: "Error", description: error.debugDescription, actions: self.defaultAlertButton())
        }
        viewModel.updateMoviesList = { [weak self] movies in
            guard let self = self  else { return }
            self.applySnapshot()
        }
        viewModel.updateMoviesListFromPagination = { [weak self] movies in
            guard let self = self  else { return }
            self.showPaginationLoader = false
            self.applySnapshot(with: false)
        }
    }
    /// Creates empty place holder for empty search result
    /// - Returns: returns optional Image view
    func getEmptyPlaceholderView() -> UIImageView? {
        if viewModel.movies.count > 0 {
            return nil
        }
        let imageView = UIImageView(image: UIImage(named: "emptyPlaceholder"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}
// MARK:- Search controller
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard (searchController.searchBar.text ?? "").count > 2 else { return }
        /// If search word is same no need to call service again
        guard searchController.searchBar.text != viewModel.searchKeyword else { return }
        viewModel.searchMovies(searchKeyWord)
    }
    /// Creates search view controller and adds it to navigation controller
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
// MARK:- Collection view layout
extension SearchViewController {
    func configireCollectionViewLayout() {
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier())
        collectionView.register(FooterLoaderCollectionReusableView.nib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterLoaderCollectionReusableView.reuseIdentifier())
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
          let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
          let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.absolute(isPhone ? 280 : 250)
          )
          let itemCount = isPhone ? 2 : 4
          let item = NSCollectionLayoutItem(layoutSize: size)
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
          let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
          section.interGroupSpacing = 10
        ///   Supplementary footer view setup
          let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: self.showPaginationLoader ? .estimated(50) : .estimated(.zero)
          )
          let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .top
          )
          section.boundarySupplementaryItems = [footer]
          return section
        })
    }
}
// MARK:- Search view controller delegate methods
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath), let imdbID = movie.imdbID else { return }
        self.view.endEditing(true)
        coordinator?.showMovieDetailsScreen(with: imdbID)
    }
}
// MARK:- Pagination logic
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
        if checkIsCollectionScrolledToTheEnd(), !showPaginationLoader, (searchController.searchBar.text ?? "").count > 2 {
            showPaginationLoader = true
            collectionView.collectionViewLayout.invalidateLayout()
            viewModel.loadNextPage(searchKeyWord)
        }
    }
    /// Check whether collection view is scrooled to bottom or not
    /// - Returns: Returns bool value
    func checkIsCollectionScrolledToTheEnd() -> Bool {
        (collectionView.contentSize.height - (collectionView.frame.height + collectionView.contentOffset.y)) < 50
    }
}
