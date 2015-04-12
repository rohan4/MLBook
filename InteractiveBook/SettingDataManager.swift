//
//  SettingDataManager.swift
//  InteractiveBook
//
//  Created by yiqin on 4/11/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit

class SettingDataManager: NSObject {
    
    private var isAutoPlay: NSNumber = 0
    
    class var sharedInstance : SettingDataManager {
        struct Static {
            static let instance = SettingDataManager()
        }
        return Static.instance
    }
    
    func fetchDataFromNSUserDefaults() {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("isAutoPlay") as? NSData {
            let tempSet: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            isAutoPlay = tempSet as! NSNumber
        }
    }
    
    func getAutoPlay()->Bool {
        let tempIsAutoPlay = isAutoPlay.integerValue
        if tempIsAutoPlay == 0 {
            // return false
            return true
        }
        else {
            return true
        }        
    }
    
    func disableAutoPlay() {
        isAutoPlay = 0
        
        let tempIsAutoPlay = NSNumber(integer: 0)
        let data = NSKeyedArchiver.archivedDataWithRootObject(tempIsAutoPlay)
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "isAutoPlay")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func enableAutoPlay() {
        isAutoPlay = 1
        
        let tempIsAutoPlay = NSNumber(integer: 1)
        let data = NSKeyedArchiver.archivedDataWithRootObject(tempIsAutoPlay)
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "isAutoPlay")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
