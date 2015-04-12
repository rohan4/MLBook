//
//  Product.swift
//  testflighthub
//
//  Created by Yi Qin on 12/20/14.
//  Copyright (c) 2014 Yi Qin. All rights reserved.
//

import UIKit

class Product: NSParseObject {
    
    var title: String
    var image : NSParseImage
    var releasedAt : NSDate
    
    override init(parseObject:PFObject) {
        
        if let tempName = parseObject["title"] as? String {
            title = tempName
        }
        else {
            title = ""
        }
        
        if let tempIconImagePFFile = parseObject["image"] as? PFFile {
            image = NSParseImage(PFFile: tempIconImagePFFile)
        }
        else {
            image = NSParseImage()
        }
        
        if let tempReleasedAt = parseObject["releasedAt"] as? NSDate {
            releasedAt = tempReleasedAt
        }
        else {
            releasedAt = NSDate()
        }
        
        super.init(parseObject:parseObject)
        
    }
    
    override init(parseClassName:String){
        title = ""
        image = NSParseImage()
        releasedAt = NSDate()
        
        super.init(parseClassName:parseClassName)
    }
    
}
