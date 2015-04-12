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
    var imageView: UIImageView!
    
    var backButton:UIButton
    var speakButton:UIButton
    
    
    var titleView: UIView!
    
    
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
        
        imageView = UIImageView()
        
        backButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        speakButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        // init value, will be changed later.
        self.pageIndex = 0
        
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
        
        speakButton.frame = CGRectMake(CGRectGetWidth(view.frame)-90, CGRectGetHeight(view.frame)-40, 80, 30)
        speakButton.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin
        speakButton.setTitle("Play", forState: UIControlState.Normal)
        // backButton.backgroundColor = UIColor.blackColor()
        speakButton.setTitleColor(UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 240.0/255.0), forState: UIControlState.Normal)
        speakButton.layer.cornerRadius = CGFloat(5.0)
        speakButton.addTarget(self, action: "speakButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        // view.addSubview(speakButton)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        imageView.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "buttonTapped:")
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        if SettingDataManager.sharedInstance.getAutoPlay() {
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "autoPlaySound", userInfo: nil, repeats: false)
        }
        
        speechSynthesizer = AVSpeechSynthesizer()
        speechSynthesizer.delegate = self
        speechSynthesizer .pauseSpeakingAtBoundary(AVSpeechBoundary.Word)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        titleView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        view.addSubview(titleView)
        
        titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame)-200, 80)
        titleLabel.center = titleView.center
        view.addSubview(titleLabel)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.titleLabel.alpha = 1.0
            self.titleView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        })

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        StoryDataManager.sharedInstance.pausedSound()
        
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func autoPlaySound(){
        StoryDataManager.sharedInstance.playSound(self.pageIndex)
        playSiriSound()
    }
    
    func buttonTapped(sender: UITapGestureRecognizer) {
        if (sender.state == .Ended) {
            println("worked")
        }
    }
    
    func backButtonAction(sender:UIButton!) {
        parentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func speakButtonAction(sender:UIButton!) {
        StoryDataManager.sharedInstance.playSound(pageIndex)
        playSiriSound()
    }
    
    func playSiriSound(){
        let utterance = AVSpeechUtterance(string: titleLabel.text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        utterance.pitchMultiplier = 0.85
        speechSynthesizer.speakUtterance(utterance)
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!) {
        let text = NSMutableAttributedString(string: titleLabel.text!)
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: characterRange)
        titleLabel.attributedText = text
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        titleLabel.attributedText = NSAttributedString(string: titleLabel.text!)
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        titleLabel.attributedText = NSAttributedString(string: titleLabel.text!)
    }
    
    
    
    
    
    
    
    
    
    
}
