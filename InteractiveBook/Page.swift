//
//  Page.swift
//  InteractiveBook
//
//  Created by yiqin on 4/11/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit
import AVFoundation

class Page: NSObject {
    
    var title:String!
    var image:UIImage!
    
    var soundEffect:AVAudioPlayer!
    
    
    
    init(title: String?, image: UIImage?, file:NSString?, type:NSString?) {
        super.init()
        
        self.title = title
        self.image = image
        soundEffect = self.setupAudioPlayerWithFile(file!, type: type!)
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType:type as String)
        var url = NSURL.fileURLWithPath(path!)
        var error: NSError?
        
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        return audioPlayer!
    }
   
}
