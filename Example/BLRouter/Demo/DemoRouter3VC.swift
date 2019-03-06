//
//  DemoRouter3VC.swift
//  BLRouter_Example
//
//  Created by lin bo on 2019/3/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class DemoRouter3VC: UIViewController {

    let tableView: UITableView = UITableView()
    let funArr: Array<String> = ["调用方法", "调用方法,返回Objcet", "调用方法,异步回调", "调用方法,携带参数"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
    }
}

extension DemoRouter3VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = funArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch funArr[indexPath.row] {
        case "调用方法":
            
            BLRouter.register("action://func1") { (dic, hander) in
                print("[调用方法] 执行成功")
            }
            BLRouter.open("action://func1", deregisterAfterUsed: true)
            break
        case "调用方法,返回Objcet":
            
            BLRouter.register("object://func2") { (dic, hander) in
                return NSObject()
            }
            let obj = BLRouter.object("object://func2", deregisterAfterUsed: true)
            print("[调用方法,返回Objcet]: \(obj.debugDescription)")
            break
        case "调用方法,异步回调":
            
            BLRouter.register("action://func3") { (dic, hander) in
                
                if let hander = hander {
                    hander(NSObject())
                }
            }
            BLRouter.open("action://func3", deregisterAfterUsed: true) { (obj) in
                print("[调用方法,异步回调]: \(obj.debugDescription)")
            }
            break
        case "调用方法,携带参数":
            
            BLRouter.register("action://func4") { (dic, hander) in
                print("[调用方法,携带参数]: \(String(describing: dic?[MGJRouterParameterUserInfo]))")
            }
            BLRouter.open("action://func4", userInfo: ["a":"A","b":NSObject()], deregisterAfterUsed: true)
            break

        default:
            break
        }
    }


}
