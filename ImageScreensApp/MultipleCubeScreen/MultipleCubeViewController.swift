//
//  MultipleCubeViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

class MultipleCubeViewController: UIViewController {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!

    var multipleCubeViewModel = MultipleCubeViewModel()
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    private func setupCollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        imageCollectionView.collectionViewLayout = layout
        imageCollectionView.register(ImageCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    private func animateCollectionView(_ collectionView: UICollectionView) {
        for index in 0..<self.multipleCubeViewModel.imageStringList.count {
            UIView.animate(withDuration: 1) {
                let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0))
                let side = self.imageCollectionView.bounds.height / 3
                cell?.bounds.size = CGSize(width: side, height: side)
            }
        }
    }
}

extension MultipleCubeViewController: UICollectionViewDelegate {
    
}

extension MultipleCubeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return multipleCubeViewModel.imageStringList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        

        
        cell.delegate = self
        cellCompletion(cell, collectionView)
        let indexCell = indexPath.row
        cell.configure(with: multipleCubeViewModel.imageStringList[indexCell], at: indexCell)
        
        return cell
    }
    
    private func cellCompletion(_ sender: ImageCollectionViewCell, _ collectionView: UICollectionView) {
        sender.completion = { [self] imageString, indexCell in
            self.multipleCubeViewModel.setIndexCell(at: indexCell)
            self.multipleCubeViewModel.setNewImage(with: imageString)
            
            if multipleCubeViewModel.isEqualTwoArrays() {
                animateCollectionView(collectionView)
            }
        }
    }
}

extension MultipleCubeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (imageCollectionView.bounds.width - 2 * Constants.spacing - 2 * Constants.sideSpacing) / 3
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
        let popUpViewModel = PopUpViewModel(selectedImageString: imageString, indexCell: index)
        popUpViewController.popUpViewModel = popUpViewModel
        popUpCompletion(popUpViewController)
        self.present(popUpViewController, animated: true)
        

    }
    
    private func popUpCompletion(_ sender: PopUpViewController) {
        sender.completion = { [weak self] imageString, indexCell in
            guard let self = self else { return }
            self.multipleCubeViewModel.setIndexCell(at: indexCell)
            self.multipleCubeViewModel.setNewImage(with: imageString)
            let indexPath = IndexPath(item: indexCell, section: 0)
            self.imageCollectionView.reloadItems(at: [indexPath])
            
            if self.multipleCubeViewModel.isEqualTwoArrays() {
                self.animateCollectionView(self.imageCollectionView)
            }
        }
    }
}
