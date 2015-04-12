//
//  StoryViewController.swift
//  InteractiveBook
//
//  Created by Yi Qin on 4/8/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.clearColor()
        
        reset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reset() {
        pageViewController = UIPageViewController()
        self.pageViewController.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(ReadPagingDataManger.sharedInstance.getTempPagingNumber())
        
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.pageViewController.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageContentViewController).pageIndex
        index++
        if(index >= StoryDataManager.sharedInstance.pages.count){
            return nil
        }
        
        ReadPagingDataManger.sharedInstance.updateTempPagingNumber(index)
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageContentViewController).pageIndex
        if(index <= 0){
            return nil
        }
        index--
        
        ReadPagingDataManger.sharedInstance.updateTempPagingNumber(index)
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        if((index >= StoryDataManager.sharedInstance.pages.count)) {
            return nil
        }
        let pageContentViewController = PageContentViewController(pageIndex: index)
        
        let tempPage = StoryDataManager.sharedInstance.pages[index]
        pageContentViewController.page = tempPage
        pageContentViewController.imageView.image = tempPage.image
        pageContentViewController.titleLabel.text = tempPage.title
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return StoryDataManager.sharedInstance.pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
