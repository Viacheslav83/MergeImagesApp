//
//  MultipleCubeViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

class MultipleCubeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var multipleCubeViewModel = MultipleCubeViewModel()
    var selectedImage: UIImage?
    
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
        return multipleCubeViewModel.imageStringList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cellCompletion(cell)
        let indexCell = indexPath.row
        cell.configure(with: multipleCubeViewModel.imageStringList[indexCell], at: indexCell)
        return cell
    }
    
    private func cellCompletion(_ sender: ImageCollectionViewCell) {
        sender.completion = { [self] imageString, indexCell in
            self.multipleCubeViewModel.setIndexCell(at: indexCell)
            self.multipleCubeViewModel.setNewImage(with: imageString)
        }
    }
}

extension MultipleCubeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.collectionView.bounds.height - 2 * Constants.spacing) / 3
        return CGSize(width: height, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing,
                            left: 0,
                            bottom: Constants.spacing,
                            right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
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
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
}
