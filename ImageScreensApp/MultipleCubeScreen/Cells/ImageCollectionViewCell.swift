//
//  ImageCollectionViewCell.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

protocol ImageCollectionViewCellDelegate: AnyObject {
    func didTappedImage(_ sender: UICollectionViewCell, at imageName: String, with indexCell: Int)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    private var listImageNames = [String]()
    static let identifier = "ImageCollectionViewCell"
    
    private let cubeTranslation = CubeTransition()
    private var direction: CubeTransitionDirection?
    private var sideImageView: UIImageView?
    
    var completion: ((_ imageName: String, _ selectedIndexCell: Int) -> Void)?
    private var selectedIndexCell: Int?
    private var nextIndexImageName: Int?
    
    private var currentImageName = ""
    weak var delegate: ImageCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSwipe()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        listImageNames = [""]
    }
    
    func setup(with imageName: String, at index: Int, from list: [String]) {
        imageView.image = UIImage(named: imageName)
        currentImageName = imageName
        listImageNames = list
        selectedIndexCell = index
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
        delegate?.didTappedImage(self, at: currentImageName, with: selectedIndexCell ?? 0)
    }
    
    private func rotateView() {
        if (sideImageView == nil) {
            sideImageView = UIImageView.init(frame: contentView.bounds)
        } else {
            sideImageView!.removeFromSuperview()
        }
        
        guard let currentIndex = listImageNames.firstIndex(of: currentImageName) else { return }

        switch direction {
        case .down:
            nextIndexImageName = listImageNames.getPreviousIndex(currentIndex)
            guard let image = UIImage(named: listImageNames[nextIndexImageName ?? 0]) else { return }
            sideImageView!.image = image
        case .up:
            nextIndexImageName = listImageNames.getNextIndex(currentIndex)
            guard let image = UIImage(named: listImageNames[nextIndexImageName ?? 0]) else { return }
            sideImageView!.image = image
        default:
            break
        }

        cubeTranslation.translateView(imageView,
                                      toView: sideImageView!,
                                      direction: direction!,
                                      duration: Constants.duration) { [weak self] (displayView) in
            guard let self = self else { return }
            self.imageView.image = displayView.image
            self.currentImageName = self.listImageNames[self.nextIndexImageName ?? 0]
        }
        completion?(listImageNames[nextIndexImageName ?? 0], selectedIndexCell ?? 0)
    }
}
