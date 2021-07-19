//
//  CollectionImageViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 12.07.2021.
//

import UIKit

struct Constants {
    static let spacing: CGFloat = 10
    static let loopingMargin: Int = 100
}

class CollectionImageViewController: UIViewController {

    @IBOutlet weak var rightCollectionView: UICollectionView!
    @IBOutlet weak var leftCollectionView: UICollectionView!
    
    var collectionImageViewModel = CollectionImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftCollectionView()
        setupRightCollectionView()
    }

    private func setupLeftCollectionView() {
        leftCollectionView.delegate = self
        leftCollectionView.dataSource = self
        
        let index = collectionImageViewModel.leftListImageString.count / 2
        leftCollectionView.scrollToItem(at: IndexPath(index: index * Constants.loopingMargin), at: .centeredVertically, animated: true)
        
        let leftLayout = UICollectionViewFlowLayout()
        leftLayout.scrollDirection = .vertical
        leftCollectionView.collectionViewLayout = leftLayout
        leftCollectionView.register(ImagePickerCollectionViewCell.nib(),
                                    forCellWithReuseIdentifier: ImagePickerCollectionViewCell.identifier)
    }
    
    private func setupRightCollectionView() {
        rightCollectionView.delegate = self
        rightCollectionView.dataSource = self
        
        let index = collectionImageViewModel.rightListImageString.count / 2
        rightCollectionView.scrollToItem(at: IndexPath(index: index * Constants.loopingMargin), at: .centeredVertically, animated: true)
        
        let rightLayout = UICollectionViewFlowLayout()
        rightLayout.scrollDirection = .vertical
        rightCollectionView.collectionViewLayout = rightLayout
        rightCollectionView.register(ImagePickerCollectionViewCell.nib(),
                                     forCellWithReuseIdentifier: ImagePickerCollectionViewCell.identifier)
    }
}

extension CollectionImageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabBarController?.selectedIndex = 0
    }
}

extension CollectionImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if collectionView == leftCollectionView {
            count = collectionImageViewModel.leftListImageString.count * Constants.loopingMargin
        } else {
            count = collectionImageViewModel.rightListImageString.count * Constants.loopingMargin
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == leftCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCollectionViewCell.identifier, for: indexPath) as? ImagePickerCollectionViewCell else { return UICollectionViewCell() }
            let index = collectionImageViewModel.indexedLoop(at: indexPath.row, list: collectionImageViewModel.leftListImageString)
            let image = UIImage(named: collectionImageViewModel.leftListImageString[index])
            cell.configure(with: image ?? UIImage())
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCollectionViewCell.identifier, for: indexPath) as? ImagePickerCollectionViewCell else { return UICollectionViewCell() }
            let index = collectionImageViewModel.indexedLoop(at: indexPath.row, list:  collectionImageViewModel.rightListImageString)
            let image = UIImage(named: collectionImageViewModel.rightListImageString[index])
            cell.configure(with: image ?? UIImage())
            return cell
        }
    }
}

extension CollectionImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = leftCollectionView.bounds.size.width
        let height = (leftCollectionView.bounds.height - 2 * Constants.spacing) / 2
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let halfSpacing = Constants.spacing / 2
        return UIEdgeInsets(top: halfSpacing,
                            left: 0,
                            bottom: halfSpacing,
                            right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
}
