//
//  ReadPagingDataManger.swift
//  InteractiveBook
//
//  Created by Yi Qin on 4/8/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit

/// Save the current paging number.
class ReadPagingDataManger: NSObject {
    
    private var tempList : NSMutableSet = NSMutableSet()
    private var tempPagingNumber : NSNumber = 0
    
    class var sharedInstance : ReadPagingDataManger {
        struct Static {
            static let instance = ReadPagingDataManger()
        }
        return Static.instance
    }
    
    func fetchDataFromNSUserDefaults() {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("readPaging") as? NSData {
            let tempSet: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            tempList = tempSet as! NSMutableSet
        }
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("tempPagingNumber") as? NSData {
            let tempSet: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            tempPagingNumber = tempSet as! NSNumber
        }
    }
    
    func updateTempPagingNumber(paging:Int) {
        tempPagingNumber = NSNumber(integer: paging)
        let data = NSKeyedArchiver.archivedDataWithRootObject(tempPagingNumber)
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "tempPagingNumber")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getTempPagingNumber() ->Int {
        return tempPagingNumber.integerValue
    }
    
    
    
    func checkItem(item:NSParseObject)->Bool {
        return tempList.containsObject(item.objectId)
    }
    
    func addItem(item:NSParseObject) {
        tempList.addObject(item.objectId)
        let data = NSKeyedArchiver.archivedDataWithRootObject(tempList)
        
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "readPaging")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
