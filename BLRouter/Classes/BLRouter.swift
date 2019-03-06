//
//  BLRouter.swift
//  BLRouter
//
//  Created by lin bo on 2019/1/24.
//  Copyright © 2019 lin bo. All rights reserved.
//

import Foundation

typealias BLRouterHander = ([String: Any]?, JYComletionHander?) -> ()
typealias BLRouterObjectHander = ([String: Any]?, JYComletionHander?) -> (Any)
typealias JYComletionHander = (Any?) -> ()

class BLRouter {

    /// 注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
    ///
    /// - Parameters:
    ///   - urlPattern: 带上 scheme，如 mgj://beauty/:id
    ///   - toHandler: 该 block 会传一个字典，包含了注册的 URL 中对应的变量。
    ///     假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
    static func register(_ url: String, toHandler: @escaping BLRouterHander) {
        
        MGJRouter.registerWithHandler(url, { dic in

            let hander = dic?[MGJRouterParameterCompletion] as? JYComletionHander
            toHandler(dic, hander)
        })
    }
    
    /// 注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
    ///
    /// - Parameters:
    ///   - urlPattern: 带上 scheme，如 mgj://beauty/:id
    ///   - toObjectHandler:  该 block 会传一个字典，包含了注册的 URL 中对应的变量。
    ///     假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
    ///     自带的 key 为 @"url" 和 @"completion" (如果有的话)
    static func register(_ url: String, toObjectHandler: @escaping BLRouterObjectHander) {
        
        MGJRouter.registerWithObjectHandler(url, toObjectHandler: {dic in
            
            let hander = dic?[MGJRouterParameterCompletion] as? JYComletionHander
            return toObjectHandler(dic, hander)
        })
    }
    
    /// 取消注册某个 URL Pattern
    ///
    /// - Parameter url: URLPattern
    static func deregister(_ url: String) {
        
        MGJRouter.deregister(url)
    }
    
    /// 打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
    ///
    /// - Parameters:
    ///   - url: 带 Scheme 的 URL，如 mgj://beauty/4
    ///   - userInfo: 附加参数
    ///   - deregisterAfterUsed: 是否调用后销毁
    ///   - completion: URL 处理完成后的 callback，完成的判定跟具体的业务相关
    static func open(_ url: String, userInfo: Dictionary<String, Any>? = nil, deregisterAfterUsed: Bool = false, completion: JYComletionHander? = nil) {

        MGJRouter.open(url, userInfo, completion)
        // print("OpenURL:\(url),info:\(userInfo?.description ?? "NULL"),hander:\(completion.debugDescription)")
        if deregisterAfterUsed {
            BLRouter.deregister(url)
        }
    }
    
    /// 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
    ///
    /// - Parameters:
    ///   - forURL: 带 Scheme，如 mgj://beauty/3
    ///   - userInfo: 附加参数
    ///   - deregisterAfterUsed: 是否调用后销毁
    /// - Returns: 返回一个 object
    static func object(_ url: String, userInfo: Dictionary<String, Any>? = nil,  deregisterAfterUsed: Bool = false) -> Any? {
        
        let obj = MGJRouter.object(url, userInfo)
        // print("objectURL:\(url),info:\(userInfo?.description ?? "NULL")")

        if deregisterAfterUsed {
            BLRouter.deregister(url)
        }
        return obj
    }
    
    /// 是否可以打开URL
    ///
    /// - Parameters:
    ///   - url: 带 Scheme，如 mgj://beauty/3
    ///   - matchExactly: matchExactly
    /// - Returns: 返回BOOL值
    static func canOpen(_ url: String, matchExactly: Bool = false) -> Bool {
        
        return MGJRouter.canOpen(url:url, matchExactly)
    }

    /// 调用此方法来拼接 urlpattern 和 parameters
    ///
    /// #define jy_ROUTE_BEAUTY @"beauty/:id"
    /// [MGJRouter generateURLWithPattern:jy_ROUTE_BEAUTY, @[@13]];
    ///
    /// - Parameters:
    ///   - pattern: url pattern 比如 @"beauty/:id"
    ///   - parameters: 一个数组，数量要跟 pattern 里的变量一致
    /// - Returns: 返回生成的URL String
    static func generate(_ url: String, parameters: Array<String>) -> String? {
        
        return MGJRouter.generateURL(url, parameters)
    }
    
    /// 获取注册列表
    ///
    /// - Returns: 注册列表
    static func allRouters() -> Dictionary<AnyHashable,Any>? {
        
        return MGJRouter.allRouters()
    }
}
