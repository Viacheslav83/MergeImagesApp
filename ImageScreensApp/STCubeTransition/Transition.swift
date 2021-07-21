//
//  Transition.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

class Transition {
    
    let fromView: UIView
    let toView: UIView
    let overlayView: UIView
    let backgroundColor: UIColor
    
    var animationLayer: CALayer?
    
    /*
     * Completion closure that will get called every time
     * when the view transition is finished with contentView parameter
     */
    let completionHandler: (_ displayView: UIView) -> Void
    
    init(_ fromView: UIView,
         toView: UIView,
         overlayView: UIView,
         completion: @escaping (_ displayView: UIView) -> ())
    {
        self.fromView = fromView
        self.toView = toView
        self.overlayView = overlayView
        self.backgroundColor = fromView.backgroundColor ?? .blue
        self.completionHandler = completion
    }
}
