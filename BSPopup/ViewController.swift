//
//  ViewController.swift
//  BSPopup
//
//  Created by rrd on 2019/8/9.
//  Copyright © 2019 zbs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let btn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 20, y: 100, width: 40, height: 40))
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(clickBtn(_ :)), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    @objc func clickBtn(_ sender: UIButton) {
        
        let vc = TestPopViewController()
        vc.popStyle = .center // .sheet
        vc.show(above: self, completion: nil)
    }
}

