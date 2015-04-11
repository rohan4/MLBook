//
//  StoryDataManager.swift
//  InteractiveBook
//
//  Created by yiqin on 4/11/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit
import AVFoundation

class StoryDataManager: NSObject {
    
    var pages:[Page] = []
    
    var soundEffect:AVAudioPlayer?
    var isPlayingSound = false
    
    class var sharedInstance : StoryDataManager {
        struct Static {
            static let instance = StoryDataManager()
        }
        return Static.instance
    }
    
    func addPage(page:Page) {
        pages += [page]
    }
    
    func playSound(pageIndex: Int){
        if pageIndex < pages.count {
            let page = pages[pageIndex]
            soundEffect = page.soundEffect
            
            soundEffect!.play()
        }
    }
    
    func pausedSound(){
        if let tempSound = soundEffect {
            if soundEffect!.playing {
                // soundEffect.pause()
            }
        }

    }
}
