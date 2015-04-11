//
//  SettingViewController.swift
//  InteractiveBook
//
//  Created by yiqin on 4/10/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var backButton:UIButton
    var segmentedControl: UISegmentedControl
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        backButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        segmentedControl = UISegmentedControl (items: ["Automatically play","Tap to play"])
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = UIColor.whiteColor()
        
        backButton.frame = CGRectMake(10, 10, 80, 30)
        backButton.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin
        backButton.setTitle("Back", forState: UIControlState.Normal)
        // backButton.backgroundColor = UIColor.blackColor()
        // backButton.setTitleColor(UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 240.0/255.0), forState: UIControlState.Normal)
        backButton.layer.cornerRadius = CGFloat(5.0)
        backButton.addTarget(self, action: "backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(backButton)
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        segmentedControl.frame = CGRectMake(60, 250,400, 44)
        

        
        segmentedControl.addTarget(self, action: "segmentedControlAction:", forControlEvents: .ValueChanged)
        self.view.addSubview(segmentedControl)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if SettingDataManager.sharedInstance.getAutoPlay() {
            segmentedControl.selectedSegmentIndex = 0
        }
        else {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func backButtonAction(sender:UIButton!) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func segmentedControlAction(sender:UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                SettingDataManager.sharedInstance.enableAutoPlay()
                break
            case 1:
                SettingDataManager.sharedInstance.disableAutoPlay()
                break
            default:
                break
        }
    }
}
