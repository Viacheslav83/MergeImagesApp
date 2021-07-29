//
//  MultipleCubeViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

struct Constants {
    static let spacing: CGFloat = 4
    static let sideSpacing: CGFloat = 2
    static let duration: Float = 0.4
    static let durationMergeImages: TimeInterval = 1
}

class MultipleCubeViewController: UIViewController {
    
    @IBOutlet private weak var fullImageView: UIImageView!
    @IBOutlet private weak var levelPageControl: UISegmentedControl!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    
    private var multipleCubeViewModel = MultipleCubeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        fullImageView.image = UIImage(named: multipleCubeViewModel.getFullImage(at: 0))
    }
    
    private func setupCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        imageCollectionView.collectionViewLayout = layout
        
        let nibName = UINib(nibName: ImageCollectionViewCell.identifier, bundle: nil)
        imageCollectionView.register(nibName,
                                     forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    private func animateCollectionView() {
        let countRow = CGFloat(multipleCubeViewModel.getNumberOfLines())
        for index in 0..<multipleCubeViewModel.listImageNames.count {
            UIView.animate(withDuration: Constants.durationMergeImages) {
                unowned let cell = self.imageCollectionView.cellForItem(at: IndexPath(row: index, section: .zero))
                let side = self.imageCollectionView.bounds.height / countRow
                cell?.bounds.size = CGSize(width: side, height: side)
            }
        }
        imageCollectionView.isUserInteractionEnabled = false
    }
    
    @IBAction private func segmentedControlTapped(_ sender: UISegmentedControl) {
        multipleCubeViewModel.setListImageNames(with: sender.selectedSegmentIndex)
        fullImageView.image = UIImage(named: multipleCubeViewModel.getFullImage(at: sender.selectedSegmentIndex))
        imageCollectionView.isUserInteractionEnabled = true
        imageCollectionView.reloadData()
    }
}

extension MultipleCubeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return multipleCubeViewModel.listImageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier,
                                                            for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        cellCompletion(cell)
        
        let indexCell = indexPath.row
        cell.setup(with: multipleCubeViewModel.listImageNames[indexCell],
                       at: indexCell,
                       from: multipleCubeViewModel.originListImageNames)
        
        return cell
    }
    
    private func cellCompletion(_ sender: ImageCollectionViewCell) {
        sender.completion = { [weak self] (imageString, indexCell) in
            guard let self = self else { return }
            self.multipleCubeViewModel.setIndexCell(at: indexCell)
            self.multipleCubeViewModel.setNewImage(with: imageString)
            
            if self.multipleCubeViewModel.isEqualTwoArrays() {
                self.animateCollectionView()
            }
        }
    }
}

extension MultipleCubeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let countRow = CGFloat(multipleCubeViewModel.getNumberOfLines())
        let side = (imageCollectionView.bounds.width - (countRow - 1) * Constants.spacing - 2 * Constants.sideSpacing) / countRow
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.sideSpacing,
                            left: Constants.sideSpacing,
                            bottom: 0,
                            right: Constants.sideSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
}

extension MultipleCubeViewController: ImageCollectionViewCellDelegate {
    
    func didTappedImage(_ sender: UICollectionViewCell, at imageString: String, with index: Int) {
        let popUpStoryboard = UIStoryboard(name: "PopUp", bundle: nil)
        guard let popUpViewController = popUpStoryboard.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else { return }
        multipleCubeViewModel.setIndexCell(at: index)
        let popUpViewModel = PopUpViewModel(selectedImageString: imageString,
                                            indexCell: index,
                                            originImageStringList: multipleCubeViewModel.originListImageNames)
        popUpViewController.popUpViewModel = popUpViewModel
        popUpCompletion(popUpViewController)
        self.present(popUpViewController, animated: true)
    }
    
    private func popUpCompletion(_ sender: PopUpViewController) {
        sender.completion = { [weak self] (imageString, indexCell) in
            guard let self = self else { return }
            self.multipleCubeViewModel.setIndexCell(at: indexCell)
            self.multipleCubeViewModel.setNewImage(with: imageString)
            let indexPath = IndexPath(item: indexCell, section: 0)
            self.imageCollectionView.reloadItems(at: [indexPath])
            
            if self.multipleCubeViewModel.isEqualTwoArrays() {
                self.animateCollectionView()
            }
        }
    }
}
