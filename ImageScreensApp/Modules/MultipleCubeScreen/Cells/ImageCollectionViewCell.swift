//
//  ImageCollectionViewCell.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit
import  AudioToolbox

protocol ImageCollectionViewCellDelegate: AnyObject {
    func didTappedImage(_ sender: UICollectionViewCell, at imageName: String, with indexCell: Int)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    static let identifier = "ImageCollectionViewCell"
    private var imageCellViewModel: ImageCellViewModel!
    
    private let cubeTranslation = CubeTransition()
    private var direction: CubeTransitionDirection?
    private var sideImageView: UIImageView?
    
    var completion: ((_ imageName: String, _ selectedIndexCell: Int) -> Void)?
    weak var delegate: ImageCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSwipe()
    }
    
    func setup(with imageCellViewModel: ImageCellViewModel) {
        self.imageCellViewModel = imageCellViewModel
        setupUI()
    }
    
    private func setupUI() {
        imageView.image = UIImage(named: imageCellViewModel.currentImageName)
    }
    
    private func setupSwipe() {
        
        let swipeUp = UISwipeGestureRecognizer(target: self,
                                               action: #selector(self.handleSwipe(gesture:)))
        swipeUp.direction = .up
        self.contentView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(self.handleSwipe(gesture:)))
        swipeDown.direction = .down
        self.contentView.addGestureRecognizer(swipeDown)
        
        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(self.handleLongPress(gesture:)))
        self.contentView.addGestureRecognizer(longPress)
    }
    
    @objc
    private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            direction = .up
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            direction = .down
        }
        rotateView()
    }
    
    @objc
    private func handleLongPress(gesture: UISwipeGestureRecognizer) {
        delegate?.didTappedImage(self,
                                 at: imageCellViewModel.currentImageName,
                                 with: imageCellViewModel.selectedCellIndex)
    }
    
    private func rotateView() {
        
        var nextImageIndex = -1
        
        if (sideImageView == nil) {
            sideImageView = UIImageView.init(frame: contentView.bounds)
        } else {
            sideImageView!.removeFromSuperview()
        }
        
        switch direction {
        case .down:
            nextImageIndex = imageCellViewModel.getNextIndexImage()
        case .up:
            nextImageIndex = imageCellViewModel.getPreviousIndexImage()
        default:
            break
        }
        
        guard let image = UIImage(named: imageCellViewModel.listImageNames[nextImageIndex]) else { return }
        sideImageView!.image = image
        
        cubeTranslation.translateView(imageView,
                                      toView: sideImageView!,
                                      direction: direction!,
                                      duration: Constants.duration) { [weak self] (displayView) in
            guard let self = self else { return }
            self.vibrate()
            self.imageView.image = displayView.image
            self.imageCellViewModel.setCurrentImageName()
        }
        completion?(imageCellViewModel.listImageNames[nextImageIndex],
                    imageCellViewModel.selectedCellIndex)
    }
    
    private func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
