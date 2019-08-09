//
//  BSPopupPresentationController.swift
//  BSPopup
//
//  Created by rrd on 2019/8/9.
//  Copyright © 2019 zbs. All rights reserved.
//

import UIKit

class BSPopupPresentationController: UIPresentationController {
    
    public var backViewColor = UIColor(white: 0.1, alpha: 0.5) {
        didSet {
            backgroundView.backgroundColor = backViewColor
        }
    }
    
    private lazy var backgroundView: UIView = {
        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.backgroundColor = self.backViewColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBlankAction(_ :)))
        backgroundView.addGestureRecognizer(tap)
        return backgroundView
    }()
 
    @objc func tapBlankAction(_ tap: UITapGestureRecognizer) {
        if let sideslipController = self.presentedViewController as? BSPopupController {
            sideslipController.dismiss(completion: nil)
        } else {
            self.presentedViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    ///MARK: override
    override open func presentationTransitionWillBegin() {
        
        if let containerView = containerView {
            containerView.insertSubview(backgroundView, at: 0)
            backgroundView.frame = containerView.bounds
            excuteBackgroundAnimation()
        }
    }
    
    override open func dismissalTransitionWillBegin() {
        excuteBackgroundDismissAnimation()
    }
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    //MARK: Private Methods
    fileprivate func excuteBackgroundAnimation(){
        backgroundView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                self.backgroundView.alpha = 1
            }, completion: nil)
        }
    }
    
    fileprivate func excuteBackgroundDismissAnimation(){
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
    
}
