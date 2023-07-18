//
//  SSnakePageControl.swift
//  Pods-SSnakePageControl_Example
//
//  Created by lhMac on 2023/5/9.
//

import UIKit

@objc protocol SSnakePageControlDelegate: NSObjectProtocol {
    func pageControl(pageControl: SSnakePageControl, didClick index: Int)
}

class SSnakePageControl: UIView {
    
    @objc var config = SSnakePageConfig()
    /// 当前点所在下标
    @objc var currentPage: Int = 0
    /// 总的分页数量
    @objc var numberOfPages: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
}

private extension SSnakePageControl {
    
    func setupUI() {
        if numberOfPages == 0 || bounds.size.width == 0 || bounds.size.height == 0 {
            return
        }
        for v in subviews {
            v.removeFromSuperview()
        }
        var startX: CGFloat = 0
        var startY: CGFloat = 0
        let maxWidth = CGFloat(numberOfPages) * (config.normalSize.width + config.spaces) + (config.currentSize.width - config.normalSize.width)
        
        switch config.postionType {
            case .center:
                startX = (bounds.width - maxWidth) * 0.5
                startY = (bounds.height - config.normalSize.height) * 0.5
            case .left:
                startY = (bounds.height - config.normalSize.height) * 0.5
            case .right:
                startX = (bounds.width - maxWidth)
                startY = (bounds.height - config.normalSize.height) * 0.5
            case .top:
                startX = (bounds.width - maxWidth) * 0.5
            case .bottom:
                startX = (bounds.width - maxWidth) * 0.5
                startY = bounds.height - config.normalSize.height
            case .leftTop:
                break
            case .leftBottom:
                startY = bounds.height - config.normalSize.height
            case .rightTop:
                startX = bounds.width - maxWidth
            case .rightBottom:
                startX = bounds.width - maxWidth
                startY = bounds.height - config.normalSize.height
        }
    }
}
