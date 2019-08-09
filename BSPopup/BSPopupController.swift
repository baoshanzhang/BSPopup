//
//  BSPopupController.swift
//  BSPopup
//
//  Created by rrd on 2019/8/9.
//  Copyright © 2019 zbs. All rights reserved.
//

import UIKit
import Foundation

enum popUpStyle {
    case center
    case sheet
}

class BSPopupController: UIViewController {
    
    @IBInspectable public var backViewColor: UIColor = UIColor(white: 0.1, alpha: 0.5)
    
    public var showAnimation: BSPopupShowAnimation = BSPopupShowAnimation()
    
    public var dismissAnimation: BSPopupDismissAnimation = BSPopupDismissAnimation()
    
    /// 弹出视图的大小
    var contentSize: CGSize = CGSize(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100) {
        didSet {
            self.showAnimation.contentSize = contentSize
        }
    }
    
    /// 弹出方式
    var popStyle: popUpStyle = .center {
        didSet {
            self.showAnimation.popstyle = self.popStyle
            self.dismissAnimation.popStyle = self.popStyle
        }
    }
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.install()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.install()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.install()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    

    ///MARK: public Methods
    
    public func show(above viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController, completion: (()-> Void)? = nil) {
        viewController?.present(self, animated: true, completion: completion)
    }
    
    public func dismiss(completion: (()-> Void)? = nil ) {
        self.dismiss(animated: true, completion: completion)
    }
    
    public func install(){
        self.showAnimation.contentSize = self.contentSize
        self.showAnimation.popstyle = self.popStyle
        self.dismissAnimation.popStyle = self.popStyle
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    
    }
}

extension BSPopupController: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = BSPopupPresentationController(presentedViewController: presented, presenting: presenting)
        controller.backViewColor = backViewColor
        return controller
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return showAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimation
    }
    
}
