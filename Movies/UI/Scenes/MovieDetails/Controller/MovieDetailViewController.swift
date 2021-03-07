//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

/// Displays the movie details As of  now it has only one entry point from `SearchViewController`
class MovieDetailViewController: UIViewController, Storyboarded {
    /// Collection view data source
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieDetailsModel>
    /// Collection view snapshot
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, MovieDetailsModel>
    /// Collection view Sections
    enum Section {
      case main
    }
    // MARK:- Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK:- Internal variables
    weak var coordinator: MainCoordinator?
    var viewModel: MovieDetailsViewModel!
    var movieID: String!
    lazy var dataSource: DataSource = makeDataSource()
    // MARK:- Private variables
    private(set) var movieDetails: MovieDetailsModel!
    // MARK:- View controller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = movieDetailsContainer.resolve(MovieDetailsViewModel?.self) {
            self.viewModel = viewModel
        }
        bindViewModel()
        configireCollectionViewLayout()
        viewModel.getMovieDetails(for: movieID)
    }
    /// Bind view model outputs
    private func bindViewModel() {
        viewModel.updateMovieDetails = { [weak self] movieDetails in
            self?.movieDetails = movieDetails
            self?.applySnapshot()
        }
        viewModel.updateMovieDetailsError = { [weak self] error in
            guard let self = self else { return }
            self.showErrorMessage(with: "Error", description: error, actions: self.defaultAlertButton())
        }
    }
    // MARK:- Collection view data source
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, movie) ->
                UICollectionViewCell? in
                // 2
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MovieDetailsCollectionViewCell.reuseIdentifier(),
                    for: indexPath) as? MovieDetailsCollectionViewCell
                cell?.movieDetails = self.movieDetails
                return cell
            })
        return dataSource
    }
    /// Display udated data in collection  view
    func applySnapshot(with animation: Bool = true) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems([movieDetails])
        dataSource.apply(snapshot, animatingDifferences: animation)
    }
}

// MARK:- Collection view layout
extension MovieDetailViewController {
    func configireCollectionViewLayout() {
        collectionView.register(MovieDetailsCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieDetailsCollectionViewCell.reuseIdentifier())
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.estimated(300)
            )
            let itemCount = 1
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            return section
        })
    }
}
