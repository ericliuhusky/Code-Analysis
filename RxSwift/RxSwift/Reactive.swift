//
//  Reactive.swift
//  RxSwift
//
//  Created by Yury Korolev on 5/2/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//

/**
 Use `Reactive` proxy as customization point for constrained protocol extensions.

 General pattern would be:

 // 1. Extend Reactive protocol with constrain on Base
 // Read as: Reactive Extension where Base is a SomeType
 extension Reactive where Base: SomeType {
 // 2. Put any specific reactive extension for SomeType here
 }

 With this approach we can have more specialized methods and properties using
 `Base` and not just specialized on common base type.

 `Binder`s are also automatically synthesized using `@dynamicMemberLookup` for writable reference properties of the reactive base.
 */

@dynamicMemberLookup
/// 响应式对象
public struct Reactive<Base> {
    /// Base object to extend.
    public let base: Base
    
    /// 使用基础对象创建响应式对象
    /// - Parameter base: 基础对象
    public init(_ base: Base) {
        self.base = base
    }

    /// Automatically synthesized binder for a key path between the reactive
    /// base and one of its properties
    /// 自动使用基础对象和它的一个属性，构成的键路径，合成绑定器
    ///
    /// 动态查询基础对象的原生属性
    public subscript<Property>(dynamicMember keyPath: ReferenceWritableKeyPath<Base, Property>) -> Binder<Property> where Base: AnyObject {
        Binder(self.base) { base, value in
            // 使用键路径为原生属性赋值
            base[keyPath: keyPath] = value
        }
    }
}

/// A type that has reactive extensions.
/// 用于添加响应式扩展的协议
public protocol ReactiveCompatible {
    /// Extended type
    /// 遵循该协议的被扩展类型
    associatedtype ReactiveBase

    /// Reactive extensions.
    static var rx: Reactive<ReactiveBase>.Type { get set }

    /// Reactive extensions.
    var rx: Reactive<ReactiveBase> { get set }
}

extension ReactiveCompatible {
    /// Reactive extensions.
    /// 静态
    public static var rx: Reactive<Self>.Type {
        get { Reactive<Self>.self }
        // this enables using Reactive to "mutate" base type
        // swiftlint:disable:next unused_setter_value
        set { }
    }

    /// Reactive extensions.
    /// 响应式扩展，返回遵循该协议的对象的响应式对象
    public var rx: Reactive<Self> {
        get { Reactive(self) }
        // this enables using Reactive to "mutate" base object
        // swiftlint:disable:next unused_setter_value
        // TODO: 为什么要设置一个空的set？
        set { }
    }
}

import Foundation

/// Extend NSObject with `rx` proxy.
/// 扩展 NSObject 遵循响应式协议，添加 rx 属性
extension NSObject: ReactiveCompatible { }
