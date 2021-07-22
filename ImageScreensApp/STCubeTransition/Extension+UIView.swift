//
//  Extension+UIView.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

extension UIImageView {
    
    func fadeLayer(withTransform transform: CATransform3D) -> CALayer {
        
        let imageLayer: CALayer = CALayer.init()
        imageLayer.anchorPoint = CGPoint.init(x: 1.0, y: 1.0)
        imageLayer.frame = bounds
        imageLayer.transform = transform
        
        //Capture View
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        imageLayer.contents = newImage.cgImage
        return imageLayer
    }
}
