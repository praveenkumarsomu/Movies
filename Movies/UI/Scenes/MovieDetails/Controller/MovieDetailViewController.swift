//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Praveen on 6/3/21.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieDetailsModel>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, MovieDetailsModel>
    enum Section {
      case main
    }
    @IBOutlet weak var collectionView: UICollectionView!
    weak var coordinator: MainCoordinator?
    var viewModel: MovieDetailsViewModel!
    var movieID: String!
    private(set) var movieDetails: MovieDetailsModel!
    lazy var dataSource: DataSource = makeDataSource()
    // MARK:- View controller life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = movieDetailsContainer.resolve(MovieDetailsViewModel?.self) {
            self.viewModel = viewModel
        }
        bindViewModel()
        configireCollectionViewLayout()
        viewModel.getMovieDetails(for: movieID)
    }
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
            let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
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
