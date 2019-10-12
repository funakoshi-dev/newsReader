//
//  ViewController.swift
//  NewsReader
//
//  Created by Taku Funakoshi on 2019/10/11.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit
import XLPagerTabStrip

//class ViewController: UIViewController {
class ViewController:ButtonBarPagerTabStripViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settings.style.buttonBarItemBackgroundColor = .black
        settings.style.buttonBarItemTitleColor = .white
        buttonBarView.backgroundColor = .black
        buttonBarView.selectedBar.backgroundColor = UIColor(red:0.10, green:0.46, blue:0.82, alpha:1.0)
        buttonBarView.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 60)
        containerView.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.view.frame.height - 80)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var viewControllers:[UIViewController] = []
        let vc1 = TableViewController(style: .plain, itemInfo: "メニュー1")
        viewControllers.append(vc1)
        let vc2 = TableViewController(style: .plain, itemInfo: "メニュー2")
        viewControllers.append(vc2)
        let vc3 = TableViewController(style: .plain, itemInfo: "メニュー3")
        viewControllers.append(vc3)
        let vc4 = TableViewController(style: .plain, itemInfo: "メニュー4")
        viewControllers.append(vc4)
        return viewControllers
    }


}

