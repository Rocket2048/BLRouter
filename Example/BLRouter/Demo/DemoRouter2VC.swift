//
//  DemoRouter2VC.swift
//  JYCommon_Example
//
//  Created by lin bo on 2019/2/22.
//  Copyright © lin bo. All rights reserved.
//

import UIKit

class DemoRouter2VC: UIViewController {

    @IBOutlet weak var addKeyTF: UITextField!
    @IBOutlet weak var addValueTF: UITextField!
    
    @IBOutlet weak var getKeyTF: UITextField!
    @IBOutlet weak var getValueLbl: UILabel!
    
    @IBOutlet weak var deleteKeyTF: UITextField!
    
    @IBOutlet weak var allkeyLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self .refreshAction(nil)

    }
    
    @IBAction func addAction(_ sender: Any) {

        guard let key = addKeyTF.text, key.count > 0 else {
            return
        }
        guard let value = addValueTF.text, value.count > 0 else {
            return
        }
        BLRouter.register(key) { (dic, hander) -> (Any) in
            return value
        }
        self .refreshAction(nil)
    }
    
    @IBAction func getAction(_ sender: Any) {
        guard let key = getKeyTF.text, key.count > 0 else {
            self.getValueLbl.text = "need input key"
            return
        }
        
        guard let value = BLRouter.object(key) as? String else {
            self.getValueLbl.text = "not found"
            return
        }
        self.getValueLbl.text = value
        self .refreshAction(nil)

    }
    
    @IBAction func deleteAction(_ sender: Any) {
        guard let key = deleteKeyTF.text, key.count > 0 else {
            return
        }
        BLRouter.deregister(key)
        self .refreshAction(nil)

    }
    
    @IBAction func refreshAction(_ sender: Any?) {
        
        guard let routers = BLRouter.allRouters()?.description else {
            return
        }
        
        allkeyLbl.text = routers
    }
    
    @IBAction func bgTapped(_ sender: Any) {
        
        view.endEditing(true)
    }
    
}
