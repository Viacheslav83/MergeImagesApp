//
//  PopUpViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 22.07.2021.
//

import UIKit
import  AudioToolbox

class PopUpViewController: UIViewController {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    private let cubeTranslation = CubeTransition()
    private var direction: CubeTransitionDirection?
    private var sideImageView: UIImageView?
    
    var completion: ((_ indexCell: String, _ indexCell: Int) -> Void)?
    var popUpViewModel: PopUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: popUpViewModel.selectedImageName)
        contentView.layer.cornerRadius = 15
        setupSwipe()
    }
    
    private func setupSwipe() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(handleSwipe(gesture:)))
        swipeLeft.direction = .left
        contentView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(handleSwipe(gesture:)))
        swipeRight.direction = .right
        contentView.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(handleLongPress(gesture:)))
        swipeDown.direction = .down
        contentView.addGestureRecognizer(swipeDown)
        
        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(self.handleLongPress(gesture:)))
        self.contentView.addGestureRecognizer(longPress)
    }
    
    @objc
    private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            direction = .right
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            direction = .left
        }
        rotateImageView()
    }
    
    @objc
    private func handleLongPress(gesture: UISwipeGestureRecognizer) {
        if let currentIndex = popUpViewModel.originListImageNames.firstIndex(of: popUpViewModel.selectedImageName),
           popUpViewModel.cellIndex == currentIndex {
            completion?(self.popUpViewModel.selectedImageName, self.popUpViewModel.cellIndex)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func rotateImageView() {
        
        var nextImageIndex: Int = -1
        
        if (sideImageView == nil) {
            sideImageView = UIImageView.init(frame: contentView.bounds)
        } else {
            sideImageView!.removeFromSuperview()
        }
        
        switch direction {
        case .left:
            nextImageIndex = popUpViewModel.getNextImageIndex()
        case .right:
            nextImageIndex = popUpViewModel.getPreviousImageIndex()
        default:
            break
        }

        guard let image = UIImage(named: popUpViewModel.originListImageNames[nextImageIndex]) else { return }
        sideImageView!.image = image
        
        cubeTranslation.translateView( imageView,
                                       toView: sideImageView!,
                                       direction: direction!,
                                       duration: Constants.duration) { [weak self] (displayView) in
            guard let self = self else { return }
            self.vibrate()
            self.imageView.image = displayView.image
            self.popUpViewModel.setCurrentImageName()
        }
        
        if popUpViewModel.cellIndex != popUpViewModel.nextImageNameIndex {
            completion?(popUpViewModel.selectedImageName, popUpViewModel.cellIndex)
        }
    }
    
    private func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
