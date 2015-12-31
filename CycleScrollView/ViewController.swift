//
//  ViewController.swift
//  CycleScrollView
//
//  Created by 李硕 on 15/12/30.
//  Copyright © 2015年 李硕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       let csv = CycleScrollView(frame: CGRectMake(10, 300, 300, 100))
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()

        view1.backgroundColor = UIColor.redColor()
        view2.backgroundColor = UIColor.blueColor()
        view3.backgroundColor = UIColor.yellowColor()
        view4.backgroundColor = UIColor.cyanColor()
        csv.displaySource = [view1,view2,view3,view4]
        
        csv.scrollTimeinterval = 5.0
        self.view.addSubview(csv)
        csv.showPageControl = true
        
    }
    
    @IBOutlet var csv: CycleScrollView!

    override func viewDidLayoutSubviews() {
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()

        view1.backgroundColor = UIColor.redColor()
        view2.backgroundColor = UIColor.blueColor()
        view3.backgroundColor = UIColor.yellowColor()
        view4.backgroundColor = UIColor.cyanColor()
        csv.displaySource = [view1,view2,view3,view4]

        csv.scrollTimeinterval = 8.0
        csv.showPageControl = true
    }


    

   

}

