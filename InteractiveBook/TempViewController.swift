//
//  TempViewController.swift
//  InteractiveBook
//
//  Created by yiqin on 4/11/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

    var imageView: UIImageView!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        imageView = UIImageView()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
        imageView.image = UIImage(named: "the-imitation-game-38-high-resolution-wallpaper.jpg")
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(imageView)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
