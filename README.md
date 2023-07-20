# SSnakePageControl

[![Version](https://img.shields.io/cocoapods/v/SSnakePageControl.svg?style=flat)](https://cocoapods.org/pods/SSnakePageControl)
[![License](https://img.shields.io/cocoapods/l/SSnakePageControl.svg?style=flat)](https://cocoapods.org/pods/SSnakePageControl)
[![Platform](https://img.shields.io/cocoapods/p/SSnakePageControl.svg?style=flat)](https://cocoapods.org/pods/SSnakePageControl)

## 需求描述

产品有各种各样的需求

美术有各种各样的设计

就还有各种各样的效果

总是有各种各样的样式

## 介绍
pageControl，完全自定义

- 大小
- 位置
- border
- 图片

其他人的自定义样式不够，我就用最简单的方法写了一些。

代码不像其他人那样简洁，但是足够简单。

直接看图↓


<img src="https://github.com/shen5214444887/SSnakePageControl/blob/main/ScreenShot.png">


## 配置属性
在 `SSnakePageConfig` 中

``` Swift

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
    
    /// 未选中的 borderWidth
    @objc public var normalBorderWidth: CGFloat = 1
    /// 当前点的 borderWidth
    @objc public var currentBorderWidth: CGFloat = 1
    
    /// 未选中的 borderColor
    @objc public var normalBorderColor: UIColor?
    /// 当前点的 borderColor
    @objc public var currentBorderColor: UIColor?
    
    /// 点的间距
    @objc public var spaces: CGFloat = 4
    
    /// 切换时候的动画时间
    @objc public var changeAnimateDuration: TimeInterval = 0.2

```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SSnakePageControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SSnakePageControl'
```

## Author

🐍🐍🐍 SNAKE 🐍🐍🐍

## License

SSnakePageControl is available under the MIT license. See the LICENSE file for more info.
