//
//  PageViewController.swift
//  GuidePage_Swift
//
//  Created by MR.Sahw on 2020/11/19.
//

import UIKit

class PageViewController: UIPageViewController {

    private lazy var VC1 : UIViewController = {[unowned self] in
        let VC1 = UIViewController()
        VC1.view.backgroundColor = .yellow
        return VC1
    }()
    private lazy var VC2 : UIViewController = {[unowned self] in
        let VC2 = UIViewController()
        VC2.view.backgroundColor = .blue
        return VC2
    }()
    private lazy var VC3 : UIViewController = {[unowned self] in
        let VC3 = UIViewController()
        VC3.view.backgroundColor = .lightGray
        return VC3
    }()
    
    private lazy var pages : [UIViewController] = []
    
    private lazy var pageControl : UIPageControl = {[unowned self] in
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 100, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        return pageControl
    }()
    
    var pendingIndex = 1 // 下一个页面
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate   = self
        
        pages = [VC1, VC2, VC3]
        // 要显示的页面
        setViewControllers([VC1], direction: .forward, animated: true, completion: nil)
        // 圆点 UIPageControl maxY左下角
        view.addSubview(pageControl)
    }
    

}

extension PageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        return currentIndex == 0 ? nil : pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        return currentIndex == pages.count-1 ? nil : pages[currentIndex + 1]
    }
}

extension PageViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex =  pages.firstIndex(of: pendingViewControllers[0])!
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {// 是否过度完成
            pageControl.currentPage = pendingIndex
        }
    }
}
