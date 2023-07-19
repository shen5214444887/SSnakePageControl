//
//  SSnakePageControl.swift
//  Pods-SSnakePageControl_Example
//
//  Created by lhMac on 2023/5/9.
//

import UIKit

@objc public protocol SSnakePageControlDelegate: NSObjectProtocol {
    func pageControl(pageControl: SSnakePageControl, didClick index: Int)
}

public class SSnakePageControl: UIView {
    
    @objc public weak var delegate: SSnakePageControlDelegate?
    /// 配置项
    @objc public var config = SSnakePageConfig() {
        didSet {
            setupUI()
        }
    }
    /// 当前点所在下标
    @objc public var currentPage: Int = 0 {
        willSet(newValue) {
            delegate?.pageControl(pageControl: self, didClick: newValue)
            if newValue == self.currentPage || newValue > numberOfPages {
                return
            }
            exchangeCurrentViewIndex(old: self.currentPage, new: newValue)
        }
    }
    /// 总的分页数量
    @objc public var numberOfPages: Int = 0 {
        didSet {
            setupUI()
        }
    }
    
    /// 是否布局
    private var isLayoutSubviews: Bool = false
    private let tagHead: Int = 1000
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLayoutSubviews {
            isLayoutSubviews = true
            setupUI()
        }
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
        var otherPointViewY = startY
        if config.currentSize.height > config.normalSize.height {
            otherPointViewY += (config.currentSize.height - config.normalSize.height) * 0.5
        }
        var currPointViewY = startY
        if config.currentSize.height < config.normalSize.height {
            currPointViewY += (config.currentSize.height - config.normalSize.height) * 0.5
        }
        
        // 创建点
        for page in 0..<numberOfPages {
            if page == 0 {
                let currPointView = UIView(frame: CGRect(x: startX, y: currPointViewY, width: config.currentSize.width, height: config.currentSize.height))
                currPointView.tag = page + tagHead
                
                startX = CGRectGetMaxX(currPointView.frame) + config.spaces
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
                currPointView.addGestureRecognizer(tapGesture)
                addSubview(currPointView)
                
                if let currentImage = config.currentImage {
                    let v = UIImageView(frame: currPointView.bounds)
                    v.image = currentImage
                    v.clipsToBounds = true
                    v.contentMode = .scaleAspectFill
                    currPointView.addSubview(v)
                }
                currPointView.setupCurrent(config: config)
            } else {
                let otherPointView = UIView(frame: CGRect(x: startX, y: otherPointViewY, width: config.normalSize.width, height: config.normalSize.height))
                otherPointView.tag = page + tagHead
                
                startX = CGRectGetMaxX(otherPointView.frame) + config.spaces
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
                otherPointView.addGestureRecognizer(tapGesture)
                addSubview(otherPointView)
                
                if let normalImage = config.normalImage {
                    let v = UIImageView(frame: otherPointView.bounds)
                    v.image = normalImage
                    v.clipsToBounds = true
                    v.contentMode = .scaleAspectFill
                    otherPointView.addSubview(v)
                }
                otherPointView.setupNormal(config: config)
            }
        }
    }
    
    /// 交换当前点位
    func exchangeCurrentViewIndex(old: Int, new: Int) {
        guard let oldView = viewWithTag(old + tagHead),
              let newView = viewWithTag(new + tagHead) else {
            return
        }
        let oldViewFrame = oldView.frame
        let newViewFrame = newView.frame
        
        UIView.animate(withDuration: config.changeAnimateDuration) {
            // 单个滚动
            var lx = oldViewFrame.origin.x
            if new < old {
                lx += (self.config.currentSize.width - self.config.normalSize.width)
            }
            oldView.frame = CGRect(x: lx, y: newViewFrame.origin.y, width: self.config.normalSize.width, height: self.config.normalSize.height)
            oldView.setupNormal(config: self.config)
            
            var mx = newViewFrame.origin.x
            if new > old {
                mx -= (self.config.currentSize.width - self.config.normalSize.width)
            }
            newView.frame = CGRect(x: mx, y: oldViewFrame.origin.y, width: self.config.currentSize.width, height: self.config.currentSize.height)
            newView.setupCurrent(config: self.config)
            
            // 越过点击
            var head: Int?
            var tail: Int?
            // 左边选中到右边
            if new - old > 1 {
                head = old
                tail = new
            }
            // 右边选中到左边
            if old - new > 1 {
                head = new
                tail = old
            }
            if let head, let tail {
                for i in (head + 1)..<tail {
                    guard let ms = self.viewWithTag(i + self.tagHead) else {
                        return
                    }
                    var mx = ms.frame.origin.x
                    mx -= self.config.normalSize.width
                    mx -= (self.config.currentSize.width - self.config.normalSize.width) * 0.5
                    ms.frame = CGRect(x: mx, y: ms.frame.origin.y, width: self.config.normalSize.width, height: self.config.normalSize.height)
                    ms.setupNormal(config: self.config)
                }
            }
        }
    }
}

fileprivate extension UIView {
    
    func setupNormal(config: SSnakePageConfig) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = config.normalCornerRadius
        self.backgroundColor = config.normalColor
        
        if let normalImage = config.normalImage,
           let v = self.subviews.first as? UIImageView {
            v.frame = self.bounds
            v.image = normalImage
        }
    }
    
    func setupCurrent(config: SSnakePageConfig) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = config.currentCornerRadius
        self.backgroundColor = config.currentColor
        
        if let currentImage = config.currentImage,
           let v = self.subviews.first as? UIImageView {
            v.frame = self.bounds
            v.image = currentImage
        }
    }
}

private extension SSnakePageControl {
    
    
    @objc func clickAction(_ recognizer: UITapGestureRecognizer) {
        guard let v = recognizer.view else {
            return
        }
        let index = v.tag + tagHead
        self.currentPage = index
    }
}
