//
//  ImageCollectionViewCell.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imageStringList = ["img1", "img2", "img3", "img4", "img5", "img6", "img7", "img8", "img9"]
    
    static var identifier = "ImageCollectionViewCell"
    let cubeTranslation = CubeTransition()
    var direction: CubeTransitionDirection?
    var sideImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSwipe()
    }
    
    override func prepareForReuse() {
 
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    private func setupSwipe() {
        // Defining the Various Swipe directions (left, right, up, down)
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.contentView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.contentView.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self,
                                               action: #selector(self.handleGesture(gesture:)))
        swipeUp.direction = .up
        self.contentView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(self.handleGesture(gesture:)))
        swipeDown.direction = .down
        self.contentView.addGestureRecognizer(swipeDown)
    }
    
    @objc
    func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            direction = .right
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            direction = .left
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            direction = .up
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            direction = .down
        }
        rotateView()
    }
    
    private func rotateView() {
        if (sideImageView == nil) {
            sideImageView = UIImageView.init(frame: contentView.bounds)
        } else {
            sideImageView!.removeFromSuperview()
        }
        
        let randomNumber: Int! = (0..<imageStringList.count).randomElement()
        guard let image = UIImage(named: imageStringList[randomNumber]) else { return }
        
        switch direction {
        case .down:
            sideImageView!.image = image
        case .up:
            sideImageView!.image = image
        case .left:
            sideImageView!.image = image
        case .right:
            sideImageView!.image = image
        default:
            break
        }

        cubeTranslation.translateView( imageView,
                                      toView: sideImageView!,
                                      direction: direction!,
                                      duration: 0.5) { [weak self] (displayView) in
            guard let self = self else { return }
            self.imageView.image = displayView.image
        }
    }
}
