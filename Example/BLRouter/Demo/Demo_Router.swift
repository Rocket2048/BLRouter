//
//  Demo_Router.swift
//  JYCommon_Example
//
//  Created by lin bo on 2019/2/22.
//  Copyright © lin bo. All rights reserved.
//

import UIKit

class Demo_Router: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BLRouter"
        
        // 注册2个页面
        DR_Interface.shared.register()
    }

    @IBAction func btn1Action(_ sender: Any) {
        
        _ = BLNavigator.push("mgj://DemoVC1", needParent:true)
    }
    
    @IBAction func btn2Action(_ sender: Any) {
        
        _ = BLNavigator.push("mgj://DemoVC2", needParent:true)
    }
    
    @IBAction func btn3Action(_ sender: Any) {
        
        _ = BLNavigator.push("mgj://DemoVC3", needParent:true)
    }
}
