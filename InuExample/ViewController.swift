//
//  ViewController.swift
//  Once
//
//  Created by kingkong999yhirose on 2016/03/18.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import UIKit

class View: UIView, OnceType {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.orangeColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("View#layoutSubViews")
        once.call() {
            let button = UIButton(frame: CGRectMake(10, 10, 100, 50))
            button.backgroundColor = UIColor.yellowColor()
            button.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
            button.titleLabel?.text = "Button"
            self.addSubview(button)
        }
    }
    
    func tapped(button: UIButton) {
        button.hidden = true
        forceLayout()
    }
    
    func forceLayout() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}

class ViewController: UIViewController, OnceType {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addView()
    }
    
    private func addView() {
        once.call() {
            print("ViewController#addView in once.call: closure")
            self.view.addSubview(View(frame: CGRectMake(200, 200, 200, 200)))
        }
        once.call() {
            fatalError("Not Call")
        }
    }
    
    @IBAction func nextTapped(sender: AnyObject) {
        
    }
}

