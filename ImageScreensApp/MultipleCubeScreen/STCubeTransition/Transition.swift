//
//  Transition.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

class Transition {
    
    let fromView: UIImageView
    let toView: UIImageView
    let overlayView: UIImageView
    
    var animationLayer: CALayer?
    
    /*
     * Completion closure that will get called every time
     * when the view transition is finished with contentView parameter
     */
    let completionHandler: (_ displayView: UIImageView) -> Void
    
    init(_ fromView: UIImageView,
         toView: UIImageView,
         overlayView: UIImageView,
         completion: @escaping (_ displayView: UIImageView) -> ())
    {
        self.fromView = fromView
        self.toView = toView
        self.overlayView = overlayView
        self.completionHandler = completion
    }
}
