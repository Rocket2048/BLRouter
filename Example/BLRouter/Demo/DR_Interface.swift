//
//  DR_Interface.swift
//  JYCommon_Example
//
//  Created by lin bo on 2019/3/4.
//  Copyright © lin bo. All rights reserved.
//

import UIKit

class DR_Interface: NSObject {

    static let shared = DR_Interface()
    
    func register() {
        
        BLRouter.register("mgj://DemoVC1") { (dic, hander) -> (Any) in
            
            let vc = DemoRouter1VC()
            vc.title = "页面跳转"
            return vc
        }
        
        BLRouter.register("mgj://DemoVC2") { (dic, hander) -> (Any) in
            
            let vc = DemoRouter2VC()
            vc.title = "注册机制"
            return vc
        }
        
        BLRouter.register("mgj://DemoVC3") { (dic, hander) -> (Any) in
            
            let vc = DemoRouter3VC()
            vc.title = "使用说明"
            return vc
        }
    }
}
