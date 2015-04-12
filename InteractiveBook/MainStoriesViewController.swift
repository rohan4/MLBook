//
//  MainStoriesViewController.swift
//  InteractiveBook
//
//  Created by Yi Qin on 4/8/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit

class MainStoriesViewController: UIViewController {
    
    var startButton:UIButton
    var settingButton:UIButton

    var imageView: UIImageView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        startButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        settingButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        imageView = UIImageView()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
        imageView.image = UIImage(named: "the-imitation-game-38-high-resolution-wallpaper.jpg")
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(imageView)
        
        startButton.setTitle("Start", forState: UIControlState.Normal)
        startButton.backgroundColor = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        startButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        startButton.layer.cornerRadius = CGFloat(5.0)
        startButton.addTarget(self, action: "startButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(startButton)
        
        settingButton.setTitle("Setting", forState: UIControlState.Normal)
        settingButton.backgroundColor = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        settingButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        settingButton.layer.cornerRadius = CGFloat(5.0)
        settingButton.addTarget(self, action: "settingButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(settingButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let tempButtonWidth: CGFloat = 200
        let tempButtonHeigth: CGFloat = 44
        let tempMiddlePosition = CGRectGetWidth(self.view.frame)*0.5
        
        startButton.frame = CGRectMake(tempMiddlePosition-tempButtonWidth-30, CGRectGetHeight(self.view.frame)-tempButtonHeigth-30, tempButtonWidth, tempButtonHeigth)
        settingButton.frame = CGRectMake(tempMiddlePosition+30, CGRectGetHeight(self.view.frame)-tempButtonHeigth-30, tempButtonWidth, tempButtonHeigth)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startButtonAction(sender:UIButton!) {
        let storyViewController = StoryViewController(nibName: nil, bundle: nil)        
        navigationController?.presentViewController(storyViewController, animated: true, completion: { () -> Void in
            
        })
    }
    
    func settingButtonAction(sender:UIButton!) {
        let settingViewController = SettingViewController(nibName: nil, bundle: nil)
        navigationController?.presentViewController(settingViewController, animated: true, completion: { () -> Void in
            
        })
    }
}
