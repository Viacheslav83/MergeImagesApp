//
//  ImageCollectionViewCell.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

protocol ImageCollectionViewCellDelegate: AnyObject {
    func didTappedImage(_ sender: UICollectionViewCell, at imageString: String, with index: Int)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    let imageStringList = ["avatar_part_001", "avatar_part_002", "avatar_part_003",
                           "avatar_part_004", "avatar_part_005", "avatar_part_006",
                           "avatar_part_007", "avatar_part_008", "avatar_part_009"]
    static var identifier = "ImageCollectionViewCell"
    
    let cubeTranslation = CubeTransition()
    var direction: CubeTransitionDirection?
    var sideImageView: UIImageView?
    
    var completion: ((String, Int) -> Void)?
    var selectedIndexCell: Int?
    var nextIndex: Int?
    
    var currentImageString = ""
    weak var delegate: ImageCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSwipe()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with imageString: String, at index: Int) {
        imageView.image = UIImage(named: imageString)
        currentImageString = imageString
        selectedIndexCell = index
    }
    
    private func setupSwipe() {
        // Defining the Various Swipe directions (left, right, up, down)
        
        let swipeUp = UISwipeGestureRecognizer(target: self,
                                               action: #selector(self.handleGesture(gesture:)))
        swipeUp.direction = .up
        self.contentView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(self.handleGesture(gesture:)))
        swipeDown.direction = .down
        self.contentView.addGestureRecognizer(swipeDown)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                 action: #selector(self.handleTapGesture(gesture:)))
        self.contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            direction = .up
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            direction = .down
        }
        rotateView()
    }
    
    @objc
    func handleTapGesture(gesture: UISwipeGestureRecognizer) {
        delegate?.didTappedImage(self, at: currentImageString, with: selectedIndexCell ?? 0)
    }
    
    private func rotateView() {
        if (sideImageView == nil) {
            sideImageView = UIImageView.init(frame: contentView.bounds)
        } else {
            sideImageView!.removeFromSuperview()
        }
        
        guard let currentIndex = imageStringList.firstIndex(of: currentImageString) else { return }

        switch direction {
        case .down:
            nextIndex = imageStringList.getPreviousIndex(currentIndex)
            guard let image = UIImage(named: imageStringList[nextIndex ?? 0]) else { return }
            sideImageView!.image = image
        case .up:
            nextIndex = imageStringList.getNextIndex(currentIndex)
            guard let image = UIImage(named: imageStringList[nextIndex ?? 0]) else { return }
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
            self.currentImageString = self.imageStringList[self.nextIndex ?? 0]
        }
        completion?(imageStringList[nextIndex ?? 0], selectedIndexCell ?? 0)
    }
}
