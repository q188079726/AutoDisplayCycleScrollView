//
//  CycleScrollView.swift
//  CycleScrollView
//
//  Created by 李硕 on 15/12/30.
//  Copyright © 2015年 李硕. All rights reserved.
//

import UIKit

class CycleScrollView: UIScrollView, UIScrollViewDelegate {

    // MARK: - DataSource Method
    var displaySource: [UIView] = [UIView]() {
        didSet {
            for view in displaySource {
                view.frame = CGRectMake(0, 0, self.selfWidth, self.selfHeight)
            }
            setCurrentPage(currentPageNum)
            layoutSubContentViews()
            self.contentSize = CGSizeMake(selfWidth * 3, selfHeight)
        }
    }
    
    // MARK: - ContentView Method
    private var leftView = UIView()
    private var centerView = UIView()
    private var rightView = UIView()
    private var currentPageNum = 0
    
    private func initSubContentViews() {
        addSubview(leftView)
        addSubview(centerView)
        addSubview(rightView)
        layoutSubContentViews()
    }
    private func layoutSubContentViews() {
        leftView.frame = CGRectMake(0, 0, selfWidth, selfHeight)
        centerView.frame = CGRectMake(selfWidth, 0, selfWidth, selfHeight)
        rightView.frame = CGRectMake(selfWidth * 2, 0, selfWidth, selfHeight)
    }
    
    func renewContentOffSet() {
        let arrCount = displaySource.count
        if(self.contentOffset.x == selfWidth * 2) {
            //forward
            currentPageNum =  (currentPageNum + 1 + arrCount)%arrCount
        }else if(self.contentOffset.x == 0) {
            //backward
            currentPageNum =  (currentPageNum - 1 + arrCount)%arrCount
        }else {
            //not change
            return
        }
        setCurrentPage(currentPageNum)
        self.pageControl.currentPage = currentPageNum
        self.contentOffset = CGPointMake(selfWidth, 0)
    }
    private func setCurrentPage(pageNum:Int) {
        let arrCount = displaySource.count
        leftView.addSubview(displaySource[(pageNum - 1 + arrCount)%arrCount])
        centerView.addSubview(displaySource[pageNum])
        rightView.addSubview(displaySource[(pageNum + 1 + arrCount)%arrCount])
    }
    
    // MARK: - PageControl Method
    var indicatorDefaultColor = UIColor.lightGrayColor() {
        didSet {
            self.pageControl.pageIndicatorTintColor = indicatorDefaultColor
        }
    }
    var indicatorTintColor = UIColor.blackColor() {
        didSet {
            self.pageControl.currentPageIndicatorTintColor = indicatorTintColor
        }
    }
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.enabled = false
        pc.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - 15, self.frame.size.width, 10)
        pc.numberOfPages = self.displaySource.count
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = self.indicatorTintColor
        pc.pageIndicatorTintColor = self.indicatorDefaultColor
        return pc
    }()
    var showPageControl: Bool = false {
        didSet {
            if self.pageControl.superview == nil {
                self.superview?.addSubview(self.pageControl)
            }
            if showPageControl == true {
                self.pageControl.hidden = false
            }
            else {
                self.pageControl.hidden = true
            }
        }
    }

    // MARK: - AutoDisplay Method
    var scrollTimeinterval = 0.0 {
        didSet {
            if scrollTimeinterval > 0 {
                let timer = NSTimer.scheduledTimerWithTimeInterval(scrollTimeinterval, target: self, selector: "autoScroll", userInfo: nil, repeats: true)
                timer.fire()
            }
        }
    }
    func autoScroll() {
        self.setContentOffset(CGPoint(x: selfWidth * 2, y: 0), animated: true)
    }
    
    
    // MARK: - init Method
    private var selfWidth: CGFloat {
        get{
            return CGRectGetWidth(self.frame)
        }
    }
    private var selfHeight: CGFloat {
        get{
            return CGRectGetHeight(self.frame)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.initSubContentViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.initSubContentViews()
    }
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    //MARK:- delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        renewContentOffSet()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        renewContentOffSet()
    }
}
