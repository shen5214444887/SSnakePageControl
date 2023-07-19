//
//  SSnakePageConfig.swift
//  SSnakePageControl
//
//  Created by lhMac on 2023/5/9.
//

import UIKit

@objc public enum SSnakePagePostionType: Int {
    case center = 0
    case left
    case right
    case top
    case bottom
    case leftTop
    case leftBottom
    case rightTop
    case rightBottom
}

public class SSnakePageConfig: NSObject {

    /// 布局位置
    @objc public var postionType: SSnakePagePostionType = .center
    
    /// 未选中点的尺寸
    @objc public var normalSize: CGSize = CGSize(width: 8, height: 8)
    /// 当前点的尺寸
    @objc public var currentSize: CGSize = CGSize(width: 8, height: 8)
    
    /// 未选中点的颜色
    @objc public var normalColor: UIColor = UIColor.lightGray
    /// 当前点的颜色
    @objc public var currentColor: UIColor = UIColor.black
    
    /// 未选中点的圆角
    @objc public var normalCornerRadius: CGFloat = 4
    /// 当前点的圆角
    @objc public var currentCornerRadius: CGFloat = 4
    
    /// 未选中的图片
    @objc public var normalImage: UIImage?
    /// 当前点的图片
    @objc public var currentImage: UIImage?
    
    /// 点的间距
    @objc public var spaces: CGFloat = 4
    
    /// 切换时候的动画时间
    @objc public var changeAnimateDuration: TimeInterval = 0.2
}
