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


/// 约束项
public final class ConstraintItem {
    
    // 目标，约束项为常量时值为nil；约束项为约束视图时，值为约束视图
    internal weak var target: AnyObject?
    /// 约束属性
    internal let attributes: ConstraintAttributes
    
    /// 使用约束视图和约束属性构建约束项
    /// - Parameters:
    ///   - target: 目标
    ///   - attributes: 约束属性
    internal init(target: AnyObject?, attributes: ConstraintAttributes) {
        self.target = target
        self.attributes = attributes
    }
    
    // 当约束项为约束视图时，可以得到转化的布局约束项
    internal var layoutConstraintItem: LayoutConstraintItem? {
        return self.target as? LayoutConstraintItem
    }
    
}

public func ==(lhs: ConstraintItem, rhs: ConstraintItem) -> Bool {
    // pointer equality
    guard lhs !== rhs else {
        return true
    }
    
    // must both have valid targets and identical attributes
    guard let target1 = lhs.target,
          let target2 = rhs.target,
          target1 === target2 && lhs.attributes == rhs.attributes else {
            return false
    }
    
    return true
}
