//
//  RootPageViewController.swift
//  testing_MC_IC041717
//
//  Created by AJ on 7/9/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit

//UIPageViewControllerDataSource is added because this is going to be our data source
//UIPageViewControllerDelegate is added because this is going to control how this component move
//UIPageViewController allows self.dataSource and self.delegate
class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //lazy b/c we won't know ahead of time view hasn't completely loaded
    lazy var vcArray: [UIViewController] = {
        
        let storyBoard = UIStoryboard(name: "main", bundle: nil) //main is from deployment info/main interface
        
        let camVC = storyBoard.instantiateViewController(identifier: "CamVC")
        let appVC = storyBoard.instantiateViewController(identifier: "AppVC")
        let messVC = storyBoard.instantiateViewController(identifier: "MessVC")
        
        return [appVC, camVC, messVC]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //to fix Type 'RootPageViewController' does not conform to protocol 'UIPageViewControllerDataSource' error
        // we need to declare that we are indeed going to be managing this ourselves
        
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = self.vcArray.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
            guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
                
            let prevIndex = vcIndex - 1
        
            guard prevIndex >= 0 else { return vcArray.last }
        
            guard vcArray.count > prevIndex else { return nil }
        
            return vcArray[prevIndex]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
            guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
            
            let nextIndex = vcIndex + 1
            
            guard nextIndex < vcArray.count else { return vcArray.last }
            
            guard vcArray.count > nextIndex else { return nil }
            
            return vcArray[nextIndex]
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
