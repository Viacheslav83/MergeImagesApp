//
//  ImageCollectionViewCell.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ownView: UIView!
    
    let imageStringList = ["img1", "img2", "img3", "img4", "img5", "img6", "img7", "img8", "img9"]
    let colorArray: [UIColor] = [.red, .green, .yellow, .orange, .brown, .blue, .cyan, .magenta, .purple]
    
    static var identifier = "ImageCollectionViewCell"
    let cubeTranslation = CubeTransition()
    var subMenu: UIView?
    var direction: CubeTransitionDirection?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGesture()
    }
    
    override func prepareForReuse() {
        ownView.backgroundColor = .white
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with index: Int) {
        ownView.backgroundColor = colorArray[index]
    }
    
    private func setupGesture() {
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(rotateView))
        swipeRightGesture.direction = .right
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(rotateView))
        swipeLeftGesture.direction = .left
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(rotateView))
        swipeUpGesture.direction = .up
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(rotateView))
        swipeDownGesture.direction = .down
        
        ownView.addGestureRecognizer(swipeRightGesture)
        ownView.addGestureRecognizer(swipeLeftGesture)
        ownView.addGestureRecognizer(swipeUpGesture)
        ownView.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc
    func rotateView(_ sender: UISwipeGestureRecognizer) {
        if (subMenu == nil) {
            subMenu = UIView.init(frame: ownView!.bounds)
        } else {
            subMenu!.removeFromSuperview()
        }
        
        let randomNumber: Int! = (0..<colorArray.count).randomElement()
        
        setupDirection(sender)
        
        switch direction {
        case .down:
            subMenu!.backgroundColor = colorArray[randomNumber]
        case .up:
            subMenu!.backgroundColor = colorArray[randomNumber]
        case .left:
            subMenu!.backgroundColor = colorArray[randomNumber]
        case .right:
            subMenu!.backgroundColor = colorArray[randomNumber]
        default:
            break
        }
        
        cubeTranslation.translateView( ownView!,
                                      toView: subMenu!,
                                      direction: direction!,
                                      duration: 0.5) { [weak self] (displayView) in
            guard let self = self else { return }
            self.ownView.backgroundColor = displayView.backgroundColor
        }
        
    }
    
    private func setupDirection(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .down:
            direction = .down
        case .up:
            direction = .up
        case .right:
            direction = .right
        case .left:
            direction = .left
        default: break
        }
    }
}
