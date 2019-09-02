//
//  PromoPageController.swift
//  PromoOfferDemoApp
//
//  Created by tanuj on 31/08/19.
//  Copyright © 2019 Tanuj Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class PromoPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    var selectedPageIndex = 0
    var topOfferModel : AnyObject?
    var autoScrollTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    //MARK: configUI
    func configUI() {
        self.dataSource = self
        self.delegate = self
        setViewControllers([viewControllerAtIndex(0)], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        let pageControl: UIPageControl = UIPageControl.appearance(whenContainedInInstancesOf: [PromoPageController.self])
        pageControl.pageIndicatorTintColor = UIColor.darkGray
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.0/255.0, green: 111.0/255.0, blue: 212.0/255.0, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if autoScrollTimer == nil{
            autoScrollTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(changeSlide), userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        if autoScrollTimer != nil {
            autoScrollTimer!.invalidate()
            autoScrollTimer = nil
        }
    }
    
    @objc func changeSlide() {
        selectedPageIndex = selectedPageIndex + 1
        if selectedPageIndex < self.topOfferModel!.count {
            setViewControllers([viewControllerAtIndex(selectedPageIndex)], direction: .forward, animated: true, completion: nil)
        }
        else {
            selectedPageIndex = 0
        }
        setViewControllers([viewControllerAtIndex(selectedPageIndex)], direction: .forward, animated: true, completion: nil)
    }
    
    init(offerModel : AnyObject) {
        super.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        self.topOfferModel = offerModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: PageViewController
    func viewControllerAtIndex(_ index: Int) -> PromoView {
        let thumbnailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PromoView") as! PromoView
        thumbnailViewController.setValues(index: index, topOfferModel: self.topOfferModel![index])
        selectedPageIndex = index
        return thumbnailViewController
    }
    
    //MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PromoView).index
        if index == 0 {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PromoView).index
        index = index+1
        if index == self.topOfferModel?.count {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.topOfferModel!.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return selectedPageIndex
    }
    
}
