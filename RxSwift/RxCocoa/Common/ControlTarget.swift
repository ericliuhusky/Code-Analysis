//
//  ControlTarget.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 2/21/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(macOS)

import RxSwift

#if os(iOS) || os(tvOS)
    import UIKit

    typealias Control = UIKit.UIControl
#elseif os(macOS)
    import Cocoa

    typealias Control = Cocoa.NSControl
#endif

// This should be only used from `MainScheduler`
/// 封装 UIControl.addTarget(_:action:for:)，
/// 使其看起来像一个更加易用的普通回调，而不是#selector选择同一个类的@objc方法，
/// 那种方式不仅繁琐，而且必须把事件处理放在与触发事件相隔甚远的类方法中，
/// 而不是更加直觉的事件触发之后紧跟着事件处理的闭包函数
final class ControlTarget: RxTarget {
    typealias Callback = (Control) -> Void

    let selector: Selector = #selector(ControlTarget.eventHandler(_:))

    weak var control: Control?
#if os(iOS) || os(tvOS)
    let controlEvents: UIControl.Event
#endif
    var callback: Callback?
    #if os(iOS) || os(tvOS)
    init(control: Control, controlEvents: UIControl.Event, callback: @escaping Callback) {
        MainScheduler.ensureRunningOnMainThread()

        self.control = control
        self.controlEvents = controlEvents
        self.callback = callback

        super.init()

        control.addTarget(self, action: selector, for: controlEvents)

        let method = self.method(for: selector)
        if method == nil {
            rxFatalError("Can't find method")
        }
    }
#elseif os(macOS)
    init(control: Control, callback: @escaping Callback) {
        MainScheduler.ensureRunningOnMainThread()

        self.control = control
        self.callback = callback

        super.init()

        control.target = self
        control.action = self.selector

        let method = self.method(for: self.selector)
        if method == nil {
            rxFatalError("Can't find method")
        }
    }
#endif

    @objc func eventHandler(_ sender: Control!) {
        if let callback = self.callback, let control = self.control {
            callback(control)
        }
    }

    override func dispose() {
        super.dispose()
#if os(iOS) || os(tvOS)
        self.control?.removeTarget(self, action: self.selector, for: self.controlEvents)
#elseif os(macOS)
        self.control?.target = nil
        self.control?.action = nil
#endif
        self.callback = nil
    }
}

#endif
