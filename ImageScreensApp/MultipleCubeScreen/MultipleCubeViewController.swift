//
//  MultipleCubeViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

class MultipleCubeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageStringList = ["img1", "img2", "img3", "img4", "img5", "img6", "img7", "img8", "img9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let leftLayout = UICollectionViewFlowLayout()
        leftLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = leftLayout
        collectionView.register(ImageCollectionViewCell.nib(),
                                    forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
}

extension MultipleCubeViewController: UICollectionViewDelegate {
 
}

extension MultipleCubeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageStringList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        let image = UIImage(named: imageStringList[indexPath.row])
        cell.configure(with: image ?? UIImage())
        return cell
    }
}

extension MultipleCubeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height - 4 * Constants.spacing) / 3
        return CGSize(width: height, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing,
                            left: Constants.spacing,
                            bottom: Constants.spacing,
                            right: Constants.spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
}
