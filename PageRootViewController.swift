//
//  PageRootViewController.swift
//  Page
//
//  Created by Ashwin Tallapaka on 1/21/17.
//  Copyright © 2017 Ashwin Tallapaka. All rights reserved.
//

import UIKit

class PageRootViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
   lazy var vcArray: [UIViewController]  =  // It need to be decalred with lazy as Storyboard is not initiated at the very begining with the pageviewcontroller
        
    {
        return [self.instanceVC(name:"BlueVC"),
                self.instanceVC(name:"OrangeVC"),
                self.instanceVC(name:"AshVC")]
    }()

    private func instanceVC(name: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    self.delegate = self
    self.dataSource = self
        
        if let firstVC = vcArray.first {
            
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl{
                view.backgroundColor = UIColor .clear
            }
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = vcArray.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return vcArray.last
        }
        
        guard vcArray.count > previousIndex else {
            return nil
        }
        
        return vcArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = vcArray.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < vcArray.count else {
            return vcArray.first
        }
        guard vcArray.count > nextIndex else {
            return nil
        }
        return vcArray[nextIndex]
    }
    
     public func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
       return vcArray.count
    }

     public func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = vcArray.index(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
}
