//
//  BLNavigator.swift
//  BLRouter
//
//  Created by lin bo on 2019/2/22.
//  Copyright © 2019 lin bo. All rights reserved.
//

import Foundation
import UIKit

public class BLNavigator {
    
    /// 获取最上层导航控制器
    ///
    /// - Returns: 最上层导航控制器
    static public func getCurrentNav() -> UINavigationController? {
        
        var parent: UIViewController?
        if let window = UIApplication.shared.delegate?.window,let rootVC = window?.rootViewController {
            parent = rootVC
            while (parent?.presentedViewController != nil) {
                parent = parent?.presentedViewController!
            }
            
            if let tabbar = parent as? UITabBarController ,let nav = tabbar.selectedViewController as? UINavigationController {
                return nav
            }else if let nav = parent as? UINavigationController {
                return nav
            }
        }
        return nil
    }
    
    /// 获取最上层VC
    ///
    /// - Returns: 最上层VC
    static public func getCurrentVC() -> UIViewController? {
        
        var parent: UIViewController?
        if let window = UIApplication.shared.delegate?.window,let rootVC = window?.rootViewController {
            parent = rootVC
            while (parent?.presentedViewController != nil) {
                parent = parent?.presentedViewController!
            }
        }
        return parent
    }
    
    /// 获取VC
    ///
    /// - Parameter url: URL
    /// - Returns: VC
    static public func getVC(_ url: String) -> UIViewController? {
        
        guard let vc = BLRouter.object(url) as? UIViewController else {
            return nil
        }
        return vc
    }
    
    /// Push VC by url
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - nav: 指定Nav 若为nil 则取最上层
    ///   - needParent: 若没有导航，则使用Parent+nav方式新增
    ///   - animated: 是否显示动画
    /// - Returns: 是否成功
    @discardableResult
    static public func push(_ url: String, nav: UINavigationController? = nil, needParent:Bool = false, animated:Bool = true) -> Bool {
        
        guard let vc = getVC(url) else {
            return false
        }
        return BLNavigator.push(vc, nav: nav, needParent:needParent, animated:animated)
    }
    
    /// Push VC
    ///
    /// - Parameters:
    ///   - vc: 目标VC
    ///   - nav: 指定Nav 若为nil 则取最上层
    ///   - needParent: 若没有导航，则使用Parent+nav方式新增
    ///   - animated: 是否显示动画
    /// - Returns: 是否成功
    @discardableResult
    static public func push(_ vc: UIViewController, nav: UINavigationController? = nil, needParent:Bool = false, animated:Bool = true) -> Bool {
        
        var nav1 = nav
        if nav1 == nil {
            nav1 = BLNavigator.getCurrentNav()
        }
        
        if nav1 == nil {
            if needParent {
                return BLNavigator.parent(vc, showNav: true, animated: animated)
            }else {
                return false
            }
        }else {
            nav1?.pushViewController(vc, animated: animated)
            return true
        }
    }
    
    /// Pop VC
    ///
    /// - Parameters:
    ///   - nav: 指定Nav 若为nil 则取最上层
    ///   - needDismiss: 已经在最底层，是否Dismiss Parent
    ///   - animated: 是否显示动画
    /// - Returns: 是否成功
    @discardableResult
    static public func pop(_ nav: UINavigationController? = nil, needDismiss:Bool = false,  animated:Bool = true) -> Bool {
        
        var nav1 = nav
        if nav1 == nil {
            nav1 = BLNavigator.getCurrentNav()
        }
        guard let nav2 = nav1 else {
            return false
        }
        if nav2.viewControllers.count == 1 {
            if needDismiss {
                return BLNavigator.dismiss()
            }else {
                return false
            }
        }else {
            nav2.popViewController(animated: animated)
            return true
        }
    }
    
    /// Pop to Root
    ///
    /// - Parameters:
    ///   - nav: 指定Nav 若为nil 则取最上层
    ///   - animated: 是否显示动画
    /// - Returns: 是否成功执行
    @discardableResult
    static public func popToRoot(_ nav: UINavigationController? = nil, animated:Bool = true) -> Bool {
        
        var nav1 = nav
        if nav1 == nil {
            nav1 = BLNavigator.getCurrentNav()
        }
        guard let nav2 = nav1 else { return false}
        
        nav2.popToRootViewController(animated: animated)
        return true
    }
    
    /// parent 推入页面
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - fromVC: 指定fromVC
    ///   - showNav: 是否需一个导航
    ///   - animated: 是否显示动画
    ///   - completion: 成功回调
    /// - Returns: 是否成功执行
    @discardableResult
    static public func parent(_ url: String, fromVC: UIViewController? = nil, showNav:Bool = false , animated:Bool = true, completion:(() -> Void)? = nil) -> Bool {
        
        let vc = BLNavigator.getVC(url)
        guard let vc1 = vc else { return false }
            
        return BLNavigator.parent(vc1, fromVC: fromVC, showNav:showNav, animated:animated, completion: completion)
    }
    
    /// parent 推入页面
    ///
    /// - Parameters:
    ///   - toVC: 推入VC
    ///   - fromVC: 指定fromVC
    ///   - showNav: 是否需一个导航
    ///   - animated: 是否显示动画
    ///   - completion: 成功回调
    /// - Returns: 是否成功执行
    @discardableResult
    static public func parent(_ toVC: UIViewController, fromVC: UIViewController? = nil, showNav:Bool = false , animated:Bool = true, completion:(() -> Void)? = nil) -> Bool {
        
        var vc1 = fromVC
        if vc1 == nil {
            vc1 = BLNavigator.getCurrentVC()
        }
        guard let vc2 = vc1 else { return false }
        
        var toVC1: UIViewController
        
        if showNav {
            let nav = UINavigationController(rootViewController: toVC)
            toVC1 = nav
        }else {
            toVC1 = toVC
        }
        
        vc2.present(toVC1, animated: animated, completion: completion)
        return true
    }
    
    /// parent 消失页面
    ///
    /// - Parameters:
    ///   - vc: 指定VC
    ///   - animated: 是否显示动画
    ///   - completion: 成功回调
    /// - Returns: 是否成功执行
    @discardableResult
    static public func dismiss(_ vc: UIViewController? = nil, animated:Bool = true, completion:(() -> Void)? = nil) -> Bool {
        
        var vc1 = vc
        if vc1 == nil {
            vc1 = BLNavigator.getCurrentVC()
        }
        
        guard let vc2 = vc1 else { return false }
        
        vc2.dismiss(animated: animated, completion: completion)
        return true
    }
}
