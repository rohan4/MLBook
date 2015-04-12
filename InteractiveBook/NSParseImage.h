//
//  NSParseImage.h
//  testflighthub
//
//  Created by Yi Qin on 3/13/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NSParseImage : NSObject

-(instancetype)initWithPFFile:(PFFile *)imageFile;
-(void)loadImage;
-(void)loadImageWithSuccess:(void (^)(UIImage *image, NSError *error))successCompletion
                    failure:(void (^)(void))failureCompletion;

@property(nonatomic, strong) NSString *fileUrl;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic) BOOL isDownloaded;

@end
