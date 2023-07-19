//
//  ViewController.swift
//  SSnakePageControl
//
//  Created by m18201692330 on 05/09/2023.
//  Copyright (c) 2023 m18201692330. All rights reserved.
//

import UIKit
import SSnakePageControl

class ViewController: UIViewController {
    
    private lazy var width = view.frame.width
    private let height: CGFloat = 100
    private let numberOfPages: Int = 5
    private let pageH: CGFloat = 30
    
    // MARK: - 默认
    private lazy var scrollView1: UIScrollView = {
        return setupScrollView(orginY: 0)
    }()
    private lazy var pageControl1: SSnakePageControl = {
        let v = SSnakePageControl(frame: CGRect(x: 0, y: (0 + height), width: width, height: pageH))
        let config = SSnakePageConfig()
        v.config = config
        v.numberOfPages = numberOfPages
        return v
    }()
    // MARK: - 长短不一，位置，颜色
    private lazy var scrollView2: UIScrollView = {
        return setupScrollView(orginY: 150)
    }()
    private lazy var pageControl2: SSnakePageControl = {
        let v = SSnakePageControl(frame: CGRect(x: 0, y: (150 + height), width: width, height: pageH))
        var config = SSnakePageConfig()
        config.postionType = .leftTop
        config.currentSize = CGSize(width: 24, height: 12)
        config.currentCornerRadius = 4
        config.spaces = 12
        config.normalColor = UIColor.green
        config.currentColor = UIColor.red
        v.config = config
        v.numberOfPages = numberOfPages
        return v
    }()
    // MARK: - 图片
    private lazy var scrollView3: UIScrollView = {
        return setupScrollView(orginY: 300)
    }()
    private lazy var pageControl3: SSnakePageControl = {
        let v = SSnakePageControl(frame: CGRect(x: 0, y: (300 + height), width: width, height: pageH))
        var config = SSnakePageConfig()
        config.normalColor = UIColor.clear
        config.normalImage = UIImage(named: "normal")
        config.normalSize = CGSize(width: 24, height: 24)
        config.normalCornerRadius = 0
        config.currentColor = UIColor.clear
        config.currentImage = UIImage(named: "current")
        config.currentSize = CGSize(width: 24, height: 14)
        config.currentCornerRadius = 0
        config.spaces = 12
        config.postionType = .rightBottom
        v.config = config
        v.numberOfPages = numberOfPages
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
    }

}

private extension ViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView1)
        view.addSubview(pageControl1)
        view.addSubview(scrollView2)
        view.addSubview(pageControl2)
        view.addSubview(scrollView3)
        view.addSubview(pageControl3)
    }
    
    func setupScrollView(orginY: CGFloat) -> UIScrollView {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: orginY, width: view.frame.width, height: height))
        scrollView.contentSize = CGSize(width: width * CGFloat(numberOfPages), height: height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        for i in 0..<numberOfPages {
            let v = UIView()
            v.backgroundColor = .random
            v.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            scrollView.addSubview(v)
        }
        return scrollView
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.size.width
        let showIndex = lroundf(Float(index))
        
        switch scrollView {
            case scrollView1:
                pageControl1.currentPage = showIndex
            case scrollView2:
                pageControl2.currentPage = showIndex
            case scrollView3:
                pageControl3.currentPage = showIndex
            default:
                break
        }
    }
}

extension UIColor {
    
    static var random: UIColor {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
    }
}
