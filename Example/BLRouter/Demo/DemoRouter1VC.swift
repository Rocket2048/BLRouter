//
//  DemoRouter1VC.swift
//  JYCommon_Example
//
//  Created by lin bo on 2019/2/22.
//  Copyright © lin bo. All rights reserved.
//

import UIKit

class DemoRouter1VC: UIViewController {
    
    let tableView: UITableView = UITableView()
    let funArr: Array<String> = ["push", "push + needParent", "pop", "pop + needDismiss", "pop to root", "parent", "parent + nav", "dismiss"]

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

extension DemoRouter1VC: UITableViewDelegate, UITableViewDataSource {
    
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
        case "push":
            _ = BLNavigator.push("mgj://DemoVC1")
            break
        case "push + needParent":
            _ = BLNavigator.push("mgj://DemoVC1", needParent: true)
            break
        case "pop":
            _ = BLNavigator.pop()
            break
        case "pop + needDismiss":
            _ = BLNavigator.pop(needDismiss: true)
            break
        case "pop to root":
            _ = BLNavigator.popToRoot()
            break
        case "parent":
            _ = BLNavigator.parent("mgj://DemoVC1")
            break
        case "parent + nav":
            _ = BLNavigator.parent("mgj://DemoVC1", showNav: true)
            break
        case "dismiss":
            _ = BLNavigator.dismiss()
            break
        default:
            break
        }
    }
}
