//
//  CubeTransition.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 21.07.2021.
//

import UIKit

/**
 A custom modal transition that presents and dismiss a controller with 3D cube roate effect.
 */

/*
 Flip animation key for animation layer
 */
private let kFlipAnimationKey = "FlipAnimation"
private let kDefaultFocalLength = 1000.0

/*
 Animation layer key to capture fromView
 */
private let fromViewKey = "FromView"

/*
 Cube transition direction options enum
 */
public enum CubeTransitionDirection: Int {
    case down = 1
    case up
    case left
    case right
}

open class CubeTransition: UICollectionViewCell, CAAnimationDelegate {
    
    private var focalLength:Double = 0.0
    private var translationQueue = [UIView: Transition]()
    
    public func translateView(_ fromView: UIView,
                              toView: UIView,
                              direction: CubeTransitionDirection,
                              duration: Float,
                              completion: @escaping (_ displayView: UIView) -> ()) {
        
        if translationQueue.keys.contains(fromView) {
            return
        }
        
        focalLength = kDefaultFocalLength
        
        let overlayView = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: fromView.frame.size))
        overlayView.alpha = 0
        overlayView.backgroundColor = fromView.superview?.backgroundColor
        fromView.addSubview(overlayView)
        
        let transition = Transition(fromView, toView: toView, overlayView: overlayView, completion: completion)
        
        let animationLayer = CALayer.init()
        animationLayer.frame = fromView.bounds
        
        var sublayerTransform:CATransform3D = CATransform3DIdentity
        sublayerTransform.m34 = CGFloat(1.0 / (-focalLength))
        animationLayer.sublayerTransform = sublayerTransform
        fromView.layer.addSublayer(animationLayer)
        
        var tranform: CATransform3D = CATransform3DMakeTranslation(0.0, 0.0, 0.0)
        let fadeOutLayer = fromView.fadeLayer(withTransform: tranform)
        animationLayer.addSublayer(fadeOutLayer)
        
        switch direction {
        case .down:
            tranform = CATransform3DTranslate(tranform, 0, -fromView.bounds.size.height, 0);
            tranform = CATransform3DRotate(tranform, CGFloat(Double.pi/2), 1, 0, 0);
            
        case .up:
            tranform = CATransform3DRotate(tranform, CGFloat(-(Double.pi/2)), 1, 0, 0);
            tranform = CATransform3DTranslate(tranform, 0, fromView.bounds.size.height, 0);
            
        case .left:
            tranform = CATransform3DRotate(tranform, CGFloat(Double.pi/2), 0, 1, 0);
            tranform = CATransform3DTranslate(tranform, fromView.bounds.size.width, 0, 0);
            
        case .right:
            tranform = CATransform3DTranslate(tranform, -fromView.bounds.size.width, 0, 0);
            tranform = CATransform3DRotate(tranform, CGFloat(-(Double.pi/2)), 0, 1, 0);
        }
        
        let fadeInLayer = toView.fadeLayer(withTransform: tranform)
        animationLayer.addSublayer(fadeInLayer)
        
        fromView.backgroundColor = UIColor.clear
        overlayView.alpha = 1
        
        rotateInDirection(transition: transition, direction: direction, animationLayer: animationLayer, duration: duration)
    }
    
    fileprivate func rotateInDirection(transition: Transition, direction: CubeTransitionDirection, animationLayer: CALayer, duration: Float) {
        
        CATransaction.flush()
        var rotation: CABasicAnimation?
        var translation: CABasicAnimation?
        var translationZ: CABasicAnimation?
        
        let group: CAAnimationGroup = CAAnimationGroup.init()
        group.delegate = self
        group.duration = CFTimeInterval(duration)
        group.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        
        switch direction {
        case .down:
            let toValue: Float = Float(transition.fromView.bounds.size.height / 2)
            translation = CABasicAnimation.init(keyPath: "sublayerTransform.translation.y")
            translation?.toValue = NSNumber.init(value: toValue)
            rotation = CABasicAnimation.init(keyPath: "sublayerTransform.rotation.x")
            rotation?.toValue = NSNumber.init(value: -(Double.pi/2))
            translationZ = CABasicAnimation.init(keyPath: "sublayerTransform.translation.z")
            translationZ?.toValue = NSNumber.init(value: -toValue)
            
        case .up:
            let toValue: Float = Float(transition.fromView.bounds.size.height / 2)
            translation = CABasicAnimation.init(keyPath: "sublayerTransform.translation.y")
            translation?.toValue = NSNumber.init(value: -toValue)
            rotation = CABasicAnimation.init(keyPath: "sublayerTransform.rotation.x")
            rotation?.toValue = NSNumber.init(value: (Double.pi/2))
            translationZ = CABasicAnimation.init(keyPath: "sublayerTransform.translation.z")
            translationZ?.toValue = NSNumber.init(value: -toValue)
            
        case .left:
            let toValue: Float = Float(transition.fromView.bounds.size.width / 2)
            translation = CABasicAnimation.init(keyPath: "sublayerTransform.translation.x")
            translation?.toValue = NSNumber.init(value: -toValue)
            rotation = CABasicAnimation.init(keyPath: "sublayerTransform.rotation.y")
            rotation?.toValue = NSNumber.init(value: -(Double.pi/2))
            translationZ = CABasicAnimation.init(keyPath: "sublayerTransform.translation.z")
            translationZ?.toValue = NSNumber.init(value: -toValue)
            
        case .right:
            let toValue: Float = Float(transition.fromView.bounds.size.width / 2)
            translation = CABasicAnimation.init(keyPath: "sublayerTransform.translation.x")
            translation?.toValue = NSNumber.init(value: toValue)
            rotation = CABasicAnimation.init(keyPath: "sublayerTransform.rotation.y")
            rotation?.toValue = NSNumber.init(value: (Double.pi/2))
            translationZ = CABasicAnimation.init(keyPath: "sublayerTransform.translation.z")
            translationZ?.toValue = NSNumber.init(value: -toValue)
        }
        
        group.animations = [rotation!, translation!, translationZ!]
        group.fillMode = CAMediaTimingFillMode.forwards
        group.isRemovedOnCompletion = false
        group.setValue(transition.fromView, forKey: fromViewKey)
        
        CATransaction.begin()
        animationLayer.add(group, forKey: kFlipAnimationKey)
        
        transition.animationLayer = animationLayer
        translationQueue[transition.fromView] = transition
        
        CATransaction.commit()
    }
    
// MARK: CAAnimation delegate methods
    public func animationDidStop(_ animation: CAAnimation, finished: Bool) {

        guard let fromView = animation.value(forKey: fromViewKey) as? UIView else {
            return
        }

        guard let transition = translationQueue[fromView] else {
            return
        }

        let overlayView = transition.overlayView
        overlayView.removeFromSuperview()

        let contentView = transition.toView
        contentView.frame = fromView.frame

        fromView.backgroundColor = transition.backgroundColor

        if let superview = fromView.superview {
            if superview.subviews.contains(contentView) == false {
                superview.addSubview(contentView)
            } else {
                superview.bringSubviewToFront(contentView)
            }
        }

        let animationLayer = transition.animationLayer
        animationLayer?.removeFromSuperlayer()
        fromView.layer.removeAllAnimations()
        contentView.layer.removeAllAnimations()

        transition.completionHandler(contentView)
        translationQueue.removeValue(forKey: fromView)
    }
}
