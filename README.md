# BLRouter 效果图

<img src="https://github.com/iosBob/BLDoc/blob/master/BLRouter/bl001.png" width="375"/>
<img src="https://github.com/iosBob/BLDoc/blob/master/BLRouter/bl002.png" width="375"/>
<img src="https://github.com/iosBob/BLDoc/blob/master/BLRouter/bl003.png" width="375"/>
<img src="https://github.com/iosBob/BLDoc/blob/master/BLRouter/bl004.png" width="375"/>

## BLRouter 接口方法

```swift

/// 注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
///
/// - Parameters:
///   - urlPattern: 带上 scheme，如 mgj://beauty/:id
///   - toHandler: 该 block 会传一个字典，包含了注册的 URL 中对应的变量。
///     假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
public static func register(_ url: String, toHandler: @escaping BLRouterHander)

/// 注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
///
/// - Parameters:
///   - urlPattern: 带上 scheme，如 mgj://beauty/:id
///   - toObjectHandler:  该 block 会传一个字典，包含了注册的 URL 中对应的变量。
///     假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
///     自带的 key 为 @"url" 和 @"completion" (如果有的话)
public static func register(_ url: String, toObjectHandler: @escaping BLRouterObjectHander)

/// 取消注册某个 URL Pattern
///
/// - Parameter url: URLPattern
public static func deregister(_ url: String)

/// 打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
///
/// - Parameters:
///   - url: 带 Scheme 的 URL，如 mgj://beauty/4
///   - userInfo: 附加参数
///   - deregisterAfterUsed: 是否调用后销毁
///   - completion: URL 处理完成后的 callback，完成的判定跟具体的业务相关
public static func open(_ url: String, userInfo: Dictionary<String, Any>? = default, deregisterAfterUsed: Bool = default, completion: JYComletionHander? = default)

/// 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
///
/// - Parameters:
///   - forURL: 带 Scheme，如 mgj://beauty/3
///   - userInfo: 附加参数
///   - deregisterAfterUsed: 是否调用后销毁
/// - Returns: 返回一个 object
public static func object(_ url: String, userInfo: Dictionary<String, Any>? = default, deregisterAfterUsed: Bool = default) -> Any?

/// 是否可以打开URL
///
/// - Parameters:
///   - url: 带 Scheme，如 mgj://beauty/3
///   - matchExactly: matchExactly
/// - Returns: 返回BOOL值
public static func canOpen(_ url: String, matchExactly: Bool = default) -> Bool

/// 调用此方法来拼接 urlpattern 和 parameters
///
/// #define jy_ROUTE_BEAUTY @"beauty/:id"
/// [MGJRouter generateURLWithPattern:jy_ROUTE_BEAUTY, @[@13]];
///
/// - Parameters:
///   - pattern: url pattern 比如 @"beauty/:id"
///   - parameters: 一个数组，数量要跟 pattern 里的变量一致
/// - Returns: 返回生成的URL String
public static func generate(_ url: String, parameters: Array<String>) -> String?

/// 获取注册列表
///
/// - Returns: 注册列表
public static func allRouters() -> Dictionary<AnyHashable, Any>?

```

## BLNavgator 接口方法

```swift

/// 获取最上层导航控制器
///
/// - Returns: 最上层导航控制器
public static func getCurrentNav() -> UINavigationController?

/// 获取最上层VC
///
/// - Returns: 最上层VC
public static func getCurrentVC() -> UIViewController?

/// 获取VC
///
/// - Parameter url: URL
/// - Returns: VC
public static func getVC(_ url: String) -> UIViewController?

/// Push VC by url
///
/// - Parameters:
///   - url: URL
///   - nav: 指定Nav 若为nil 则取最上层
///   - needParent: 若没有导航，则使用Parent+nav方式新增
///   - animated: 是否显示动画
/// - Returns: 是否成功
public static func push(_ url: String, nav: UINavigationController? = default, needParent: Bool = default, animated: Bool = default) -> Bool

/// Push VC
///
/// - Parameters:
///   - vc: 目标VC
///   - nav: 指定Nav 若为nil 则取最上层
///   - needParent: 若没有导航，则使用Parent+nav方式新增
///   - animated: 是否显示动画
/// - Returns: 是否成功
public static func push(_ vc: UIViewController, nav: UINavigationController? = default, needParent: Bool = default, animated: Bool = default) -> Bool

/// Pop VC
///
/// - Parameters:
///   - nav: 指定Nav 若为nil 则取最上层
///   - needDismiss: 已经在最底层，是否Dismiss Parent
///   - animated: 是否显示动画
/// - Returns: 是否成功
public static func pop(_ nav: UINavigationController? = default, needDismiss: Bool = default, animated: Bool = default) -> Bool

/// Pop to Root
///
/// - Parameters:
///   - nav: 指定Nav 若为nil 则取最上层
///   - animated: 是否显示动画
/// - Returns: 是否成功执行
public static func popToRoot(_ nav: UINavigationController? = default, animated: Bool = default) -> Bool

/// parent 推入页面
///
/// - Parameters:
///   - url: URL
///   - fromVC: 指定fromVC
///   - showNav: 是否需一个导航
///   - animated: 是否显示动画
///   - completion: 成功回调
/// - Returns: 是否成功执行
public static func parent(_ url: String, fromVC: UIViewController? = default, showNav: Bool = default, animated: Bool = default, completion: (() -> Void)? = default) -> Bool

/// parent 推入页面
///
/// - Parameters:
///   - toVC: 推入VC
///   - fromVC: 指定fromVC
///   - showNav: 是否需一个导航
///   - animated: 是否显示动画
///   - completion: 成功回调
/// - Returns: 是否成功执行
public static func parent(_ toVC: UIViewController, fromVC: UIViewController? = default, showNav: Bool = default, animated: Bool = default, completion: (() -> Void)? = default) -> Bool

/// parent 消失页面
///
/// - Parameters:
///   - vc: 指定VC
///   - animated: 是否显示动画
///   - completion: 成功回调
/// - Returns: 是否成功执行
public static func dismiss(_ vc: UIViewController? = default, animated: Bool = default, completion: (() -> Void)? = default) -> Bool


```


## Installation

BLRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BLRouter'
```

## Author

lin bo, ok@linbok.com

## License

BLRouter is available under the MIT license. See the LICENSE file for more info.
