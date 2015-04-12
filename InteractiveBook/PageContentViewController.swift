//
//  PageContentViewController.swift
//  InteractiveBook
//
//  Created by yiqin on 4/10/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit
import AVFoundation

class PageContentViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    var page: Page!
    
    var pageIndex: Int
    
    var titleLabel: UILabel!
    
    var pageNumberLabel: UILabel!
    
    var imageView: UIImageView!
    
    
    
    
    var backButton:UIButton
    var speakButton:UIButton
    
    
    
    
    
    var titleView: UIView!
    
    var settingView: UIView!
    var hasSettingView: Bool = false
    var settingViewHeight: CGFloat = 44
    
    // var settingButton: UIButton
    
    var speechSynthesizer: AVSpeechSynthesizer!
    
    convenience init(pageIndex:Int?) {
        self.init(nibName: nil, bundle: nil)
        self.pageIndex = pageIndex!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        titleLabel = UILabel()
        titleLabel.alpha = 0.1
        titleLabel.textColor = UIColor.whiteColor()
        // titleLabel.font = UIFont.boldSystemFontOfSize(17.0)
        
        titleLabel.font = UIFont(name: "Lato-Semibold", size: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.Center
        
        pageNumberLabel = UILabel()
        pageNumberLabel.alpha = 0.1
        pageNumberLabel.textColor = UIColor.whiteColor()
        // titleLabel.font = UIFont.boldSystemFontOfSize(17.0)
        
        pageNumberLabel.font = UIFont(name: "Lato-Semibold", size: 17)
        pageNumberLabel.numberOfLines = 0
        pageNumberLabel.textAlignment = NSTextAlignment.Center
        
        
        
        imageView = UIImageView()
        settingView = UIImageView()
        
        backButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        // init value, will be changed later.
        self.pageIndex = 0
        
        
        speakButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        view.addSubview(imageView)
        
        
        titleView = UIView(frame: CGRectMake(0, CGRectGetHeight(view.frame)-120, CGRectGetWidth(view.frame), 100))
        
        
        backButton.frame = CGRectMake(10, 10, 80, 30)
        backButton.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleBottomMargin
        backButton.setTitle("Back", forState: UIControlState.Normal)
        // backButton.backgroundColor = UIColor.blackColor()
        backButton.setTitleColor(UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 240.0/255.0), forState: UIControlState.Normal)
        backButton.layer.cornerRadius = CGFloat(5.0)
        backButton.addTarget(self, action: "backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        // view.addSubview(backButton)
        
        /*
        speakButton.frame = CGRectMake(CGRectGetWidth(view.frame)-90, CGRectGetHeight(view.frame)-40, 80, 30)
        speakButton.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin
        speakButton.setTitle("Play", forState: UIControlState.Normal)
        // backButton.backgroundColor = UIColor.blackColor()
        speakButton.setTitleColor(UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 240.0/255.0), forState: UIControlState.Normal)
        speakButton.layer.cornerRadius = CGFloat(5.0)
        speakButton.addTarget(self, action: "speakButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        // view.addSubview(speakButton)
        */
        
        speakButton.setTitle("Speak", forState: UIControlState.Normal)
        // settingButton.backgroundColor = UIColor.blackColor()
        // settingButton.layer.cornerRadius = CGFloat(5.0)
        speakButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        speakButton.addTarget(self, action: "speakButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // imageView.userInteractionEnabled = true
        imageView.userInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "buttonTapped:")
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        speechSynthesizer = AVSpeechSynthesizer()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var test1: String = titleLabel.text!
        var length = test1.lengthOfBytesUsingEncoding(NSUTF16StringEncoding)
        
        if length < 50 {
            self.titleLabel.font = UIFont(name: "Lato-Bold", size: 23)
        }
        else {
            self.titleLabel.font = UIFont(name: "Lato-Semibold", size: 15)
        }
        
        
        
        
        titleView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        view.addSubview(titleView)
        
        titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame)-200, 80)
        titleLabel.center = titleView.center
        view.addSubview(titleLabel)
        
        
        pageNumberLabel.text = "page"
        pageNumberLabel.center = titleView.center
        pageNumberLabel.frame = CGRectMake(0, CGRectGetMinY(pageNumberLabel.frame), 100, 80)
        
        // view.addSubview(pageNumberLabel)
        
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.titleLabel.alpha = 1.0
            self.titleView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        })
        
        
        settingView.backgroundColor = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        settingView.frame = CGRectMake(0, -settingViewHeight, CGRectGetWidth(view.frame), settingViewHeight)
        view.addSubview(settingView)
        settingView.userInteractionEnabled = true
        
        
        speakButton.frame = CGRectMake(CGRectGetWidth(settingView.frame)-80, 0, 80, CGRectGetHeight(settingView.frame))
        settingView.addSubview(speakButton)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        StoryDataManager.sharedInstance.pausedSound()
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        speechSynthesizer.delegate = self
        speechSynthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Word)
        
        if SettingDataManager.sharedInstance.getAutoPlay() && pageIndex > 0 {
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "autoPlaySound", userInfo: nil, repeats: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func autoPlaySound(){
        StoryDataManager.sharedInstance.playSound(self.pageIndex)
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        playSiriSound()
    }
    
    func buttonTapped(sender: UITapGestureRecognizer) {
        if (sender.state == .Ended) {
            println("worked")
            
            
            if hasSettingView {
                
                UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 5.0, options: nil, animations: { () -> Void in
                    
                    self.settingView.frame = CGRectMake(0, -self.settingViewHeight, CGRectGetWidth(self.view.frame), self.settingViewHeight)
                    
                    }, completion: { (finished: Bool) -> Void in
                        self.hasSettingView = false
                })
                
            }
            else {
                
                UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 5.0, options: nil, animations: { () -> Void in
                    
                    self.settingView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.settingViewHeight)
                    
                    }, completion: { (finished: Bool) -> Void in
                        self.hasSettingView = true
                        
                })
                
            }
            
        }
    }
    
    func backButtonAction(sender:UIButton!) {
        parentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func speakButtonAction(sender:UIButton!) {
        StoryDataManager.sharedInstance.playSound(pageIndex)
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        playSiriSound()
    }
    
    func playSiriSound(){
        let utterance = AVSpeechUtterance(string: titleLabel.text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        utterance.pitchMultiplier = 0.85
        speechSynthesizer.speakUtterance(utterance)
    }
    
    
    // speed synthesizer delegate
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!) {
        let text = NSMutableAttributedString(string: titleLabel.text!)
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 254.0/255.0, green: 108.0/255.0, blue: 113.0/255.0, alpha: 1.0), range: characterRange)
        titleLabel.attributedText = text
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        titleLabel.attributedText = NSAttributedString(string: titleLabel.text!)
        println("finsihed")
        
        
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        titleLabel.attributedText = NSAttributedString(string: titleLabel.text!)
    }
    
    
}
