//
//  PopUpViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 22.07.2021.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    let cubeTranslation = CubeTransition()
    var direction: CubeTransitionDirection?
    var sideImageView: UIImageView?
    
    var completion: ((String, Int) -> Void)?
    var popUpViewModel: PopUpViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: popUpViewModel.selectedImageString)
        contentView.layer.cornerRadius = 15
        setupSwipe()
    }
    
    private func setupSwipe() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        contentView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        contentView.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(self.handleTapGesture(gesture:)))
        swipeDown.direction = .down
        contentView.addGestureRecognizer(swipeDown)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                 action: #selector(self.handleTapGesture(gesture:)))
        self.contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            direction = .right
        } else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            direction = .left
        }
        rotateView()
    }
    
    @objc
    func handleTapGesture(gesture: UISwipeGestureRecognizer) {
        if popUpViewModel.indexCell != popUpViewModel.imageStringList.count - 1 {
            completion?(self.popUpViewModel.selectedImageString, self.popUpViewModel.indexCell)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func rotateView() {
        if (sideImageView == nil) {
            sideImageView = UIImageView.init(frame: contentView.bounds)
        } else {
            sideImageView!.removeFromSuperview()
        }
        
        guard let currentIndex = popUpViewModel.imageStringList.firstIndex(of: popUpViewModel.selectedImageString) else { return }
        var nextIndex: Int = -1
        var nextImageString = ""
        
        switch direction {
        case .left:
            nextIndex = popUpViewModel.imageStringList.getNextIndex(currentIndex)
            nextImageString = popUpViewModel.imageStringList[nextIndex]
            guard let image = UIImage(named: nextImageString) else { return }
            sideImageView!.image = image
        case .right:
            nextIndex = popUpViewModel.imageStringList.getPreviousIndex(currentIndex)
            nextImageString = popUpViewModel.imageStringList[nextIndex]
            guard let image = UIImage(named: nextImageString) else { return }
            sideImageView!.image = image
        default:
            break
        }

        cubeTranslation.translateView( imageView,
                                      toView: sideImageView!,
                                      direction: direction!,
                                      duration: Constants.duration) { [weak self] (displayView) in
            guard let self = self else { return }
            self.imageView.image = displayView.image
            self.popUpViewModel.setImageString(with: nextImageString)
        }
        if popUpViewModel.indexCell != popUpViewModel.imageStringList.count - 1 {
            completion?(nextImageString, popUpViewModel.indexCell)
        }
    }
}
