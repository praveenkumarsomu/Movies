//
//  ViewController.swift
//  Movies
//
//  Created by Praveen on 2/3/21.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Movie>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Movie>
    enum Section {
      case main
    }
    weak var coordinator: MainCoordinator?
    var viewModel: SearchViewModel!
    // MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    private var searchController = UISearchController(searchResultsController: nil)
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
        applySnapshot()
    }
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
          let section = self.dataSource.snapshot()
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
    }
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
}
// MARK:- Search controller
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard (searchController.searchBar.text ?? "").count > 2 else { return }
        viewModel.searchMovies(searchKeyWord)
    }
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
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath), let imdbID = movie.imdbID else { return }
        self.view.endEditing(true)
        coordinator?.showMovieDetailsScreen(with: imdbID)
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if checkIsCollectionScrolledToTheEnd(), !showPaginationLoader, (searchController.searchBar.text ?? "").count > 2 {
            showPaginationLoader = true
            collectionView.collectionViewLayout.invalidateLayout()
            viewModel.loadNextPage(searchKeyWord)
        }
    }
    /// Check whether collection view is scrooled to bottom or not
    /// - Returns:
    func checkIsCollectionScrolledToTheEnd() -> Bool {
        (collectionView.contentSize.height - (collectionView.frame.height + collectionView.contentOffset.y)) < 50
    }
}
