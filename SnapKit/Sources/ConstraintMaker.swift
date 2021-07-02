//
//  SnapKit
//
//  Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

/// 约束生成器
public class ConstraintMaker {
    
    public var left: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.left)
    }
    
    public var top: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.top)
    }
    
    public var bottom: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.bottom)
    }
    
    public var right: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.right)
    }
    
    public var leading: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leading)
    }
    
    public var trailing: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.trailing)
    }
    
    public var width: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.width)
    }
    
    public var height: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.height)
    }
    
    public var centerX: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerX)
    }
    
    public var centerY: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerY)
    }
    
    @available(*, deprecated, renamed:"lastBaseline")
    public var baseline: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.lastBaseline)
    }
    
    public var lastBaseline: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.lastBaseline)
    }
    
    @available(iOS 8.0, OSX 10.11, *)
    public var firstBaseline: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.firstBaseline)
    }
    
    @available(iOS 8.0, *)
    public var leftMargin: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leftMargin)
    }
    
    @available(iOS 8.0, *)
    public var rightMargin: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.rightMargin)
    }
    
    @available(iOS 8.0, *)
    public var topMargin: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.topMargin)
    }
    
    @available(iOS 8.0, *)
    public var bottomMargin: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.bottomMargin)
    }
    
    @available(iOS 8.0, *)
    public var leadingMargin: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.leadingMargin)
    }
    
    @available(iOS 8.0, *)
    public var trailingMargin: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.trailingMargin)
    }
    
    @available(iOS 8.0, *)
    public var centerXWithinMargins: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerXWithinMargins)
    }
    
    @available(iOS 8.0, *)
    public var centerYWithinMargins: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerYWithinMargins)
    }
    
    public var edges: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.edges)
    }
    public var horizontalEdges: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.horizontalEdges)
    }
    public var verticalEdges: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.verticalEdges)
    }
    public var directionalEdges: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalEdges)
    }
    public var directionalHorizontalEdges: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalHorizontalEdges)
    }
    public var directionalVerticalEdges: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalVerticalEdges)
    }
    public var size: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.size)
    }
    public var center: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.center)
    }
    
    @available(iOS 8.0, *)
    public var margins: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.margins)
    }
    
    @available(iOS 8.0, *)
    public var directionalMargins: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.directionalMargins)
    }

    @available(iOS 8.0, *)
    public var centerWithinMargins: ConstraintMakerExtendable {
        return self.makeExtendableWithAttributes(.centerWithinMargins)
    }
    
    private let item: LayoutConstraintItem
    private var descriptions = [ConstraintDescription]()
    
    
    /// 使用约束视图构建约束生成器
    /// - Parameter item: 遵循布局约束项协议的约束视图
    internal init(item: LayoutConstraintItem) {
        self.item = item
        self.item.prepare()
    }
    
    /// 使用约束属性生成可扩展的约束生成器
    /// - Parameter attributes: 约束属性
    /// - Returns: 可扩展的约束生成器
    internal func makeExtendableWithAttributes(_ attributes: ConstraintAttributes) -> ConstraintMakerExtendable {
        // 使用约束视图和约束属性构建约束描述
        let description = ConstraintDescription(item: self.item, attributes: attributes)
        
        // 在本例约束描述数组后追加约束描述
        self.descriptions.append(description)
        
        // 返回可扩展的约束生成器，以便继续增加约束描述的约束属性和设置约束描述的约束关系
        return ConstraintMakerExtendable(description)
    }
    
    
    /// 准备约束
    /// - Parameters:
    ///   - item: 遵循布局约束项协议的约束视图
    ///   - closure: 回调约束生成器的闭包
    /// - Returns: 约束数组
    internal static func prepareConstraints(item: LayoutConstraintItem, closure: (_ make: ConstraintMaker) -> Void) -> [Constraint] {
        let maker = ConstraintMaker(item: item)
        
        // 闭包回调约束生成器，以便在外部使用约束生成器添加约束
        closure(maker)
        
        // 将约束描述映射为约束
        var constraints: [Constraint] = []
        for description in maker.descriptions {
            guard let constraint = description.constraint else {
                continue
            }
            constraints.append(constraint)
        }
        return constraints
    }
    
    /// 生成约束
    /// - Parameters:
    ///   - item: 遵循布局约束项协议的约束视图
    ///   - closure: 回调约束生成器的闭包
    internal static func makeConstraints(item: LayoutConstraintItem, closure: (_ make: ConstraintMaker) -> Void) {
        let constraints = prepareConstraints(item: item, closure: closure)
        // 循环激活每个约束
        for constraint in constraints {
            constraint.activateIfNeeded(updatingExisting: false)
        }
    }
    
    internal static func remakeConstraints(item: LayoutConstraintItem, closure: (_ make: ConstraintMaker) -> Void) {
        self.removeConstraints(item: item)
        self.makeConstraints(item: item, closure: closure)
    }
    
    internal static func updateConstraints(item: LayoutConstraintItem, closure: (_ make: ConstraintMaker) -> Void) {
        guard item.constraints.count > 0 else {
            self.makeConstraints(item: item, closure: closure)
            return
        }
        
        let constraints = prepareConstraints(item: item, closure: closure)
        for constraint in constraints {
            constraint.activateIfNeeded(updatingExisting: true)
        }
    }
    
    internal static func removeConstraints(item: LayoutConstraintItem) {
        let constraints = item.constraints
        for constraint in constraints {
            constraint.deactivateIfNeeded()
        }
    }
    
}
