//
//  BSPopupAnimation.swift
//  BSPopup
//
//  Created by rrd on 2019/8/9.
//  Copyright © 2019 zbs. All rights reserved.
//

import UIKit

open class BSPopupShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    ///时间间隔
    public var duration: TimeInterval = 0.4
    
    ///延迟
    public var delay: TimeInterval = 0.0
    
    ///弹簧阻尼
    public var springWithDamping: CGFloat = 0.8
    
    ///弹性速率
    public var springVelocity: CGFloat = 2.0
    
    public var contentSize: CGSize!
    
    var popstyle: popUpStyle = .center
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: toViewController)
        containerView.addSubview(toView)
        
        switch self.popstyle {
        case .center:
            let x: CGFloat = (toView.frame.width - self.contentSize.width)/2
            let y: CGFloat = (toView.frame.height - self.contentSize.height)/2
            let width: CGFloat = self.contentSize.width
            let height: CGFloat = self.contentSize.height
            toView.frame = CGRect(x: x, y: y, width: width, height: height)
            toView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: springWithDamping, initialSpringVelocity: springVelocity, options: .curveEaseInOut, animations: {
                toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (finished) in
                transitionContext.completeTransition(finished)
            }
            
        case .sheet:
            let x: CGFloat = (toView.frame.width - self.contentSize.width)/2
            let y: CGFloat = toView.frame.height
            let width: CGFloat = self.contentSize.width
            let height: CGFloat = self.contentSize.height
            toView.frame = CGRect(x: x, y: y, width: width, height: height)
            UIView.animate(withDuration: self.duration, delay: self.delay, options: .curveEaseInOut, animations: {
                let height: CGFloat = self.contentSize.height
                toView.transform = CGAffineTransform(translationX: 0, y: -height)
            }) { (finished) in
                transitionContext.completeTransition(finished)
            }
        }
        
    }
}

open class BSPopupDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var duration: TimeInterval = 0.2
    
    public var delay: TimeInterval = 0.0
    
    var popStyle: popUpStyle = .center
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            switch self.popStyle {
            case .center:
                fromView.alpha = 0.0
            case .sheet:
                fromView.transform = CGAffineTransform.identity
            }
        }) { (finished) in
            fromView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            fromView.alpha = 1.0
            transitionContext.completeTransition(finished)
        }
    }
}
