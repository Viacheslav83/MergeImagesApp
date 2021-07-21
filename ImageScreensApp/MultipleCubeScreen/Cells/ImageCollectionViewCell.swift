//
//  ImageCollectionViewCell.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    
    static var identifier = "ImageCollectionViewCell"
    let cubeTranslation:CubeTransition = CubeTransition()
    var subMenu: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(rotateView))
        self.view.addGestureRecognizer(panGesture)
    }
    
    override func prepareForReuse() {
        view = nil
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with color: UIColor) {
        view.backgroundColor = color
    }
    
    @objc
    func rotateView() {
            if (subMenu == nil) {
                subMenu = UIView.init(frame: view!.bounds)
            } else {
                subMenu!.removeFromSuperview()
            }
        
            let direction: CubeTransitionDirection = CubeTransitionDirection(rawValue: 1)!
        
            switch direction {
            case .Down:
                subMenu!.backgroundColor = UIColor.red
        
            case .Up:
                subMenu!.backgroundColor = UIColor.blue
        
            case .Left:
                subMenu!.backgroundColor = UIColor.green
        
            case .Right:
                subMenu!.backgroundColor = UIColor.purple
            }
        
            cubeTranslation.translateView(view!, toView: subMenu!, direction: direction, duration: 0.5) { [weak self] (displayView) in
                guard let self = self else { return }
                self.view?.backgroundColor = displayView.backgroundColor
            }
            
    }
}
