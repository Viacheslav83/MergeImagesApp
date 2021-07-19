//
//  ReusableCollectionView.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 19.07.2021.
//

import UIKit

class ReusableCollectionView: UICollectionView {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupPickerView()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupPickerView()
//    }
    
    private func setupCollectionView() {
        self.delegate = self
        self.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
        self.collectionViewLayout = layout
    }
}


extension ReusableCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        tabBarController?.selectedIndex = 0
        0
    }
}

extension ReusableCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var count = 0
//        if collectionView == leftCollectionView {
//            count = collectionImageViewModel.leftListImageString.count * Constants.loopingMargin
//        } else {
//            count = collectionImageViewModel.rightListImageString.count * Constants.loopingMargin
//        }
//        return count
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCollectionViewCell.identifier, for: indexPath) as? ImagePickerCollectionViewCell else { return UICollectionViewCell() }
//            let index = collectionImageViewModel.indexedLoop(at: indexPath.row, list: collectionImageViewModel.leftListImageString)
//            let image = UIImage(named: collectionImageViewModel.leftListImageString[index])
//            cell.configure(with: image ?? UIImage())
            return cell

    }
}

extension ReusableCollectionView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = leftCollectionView.bounds.size.width
//        let height = (leftCollectionView.bounds.height - 2 * Constants.spacing) / 2
//        return CGSize(width: width, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let halfSpacing = Constants.spacing / 2
//        return UIEdgeInsets(top: halfSpacing,
//                            left: 0,
//                            bottom: halfSpacing,
//                            right: 0)
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return Constants.spacing
//    }
    
}
