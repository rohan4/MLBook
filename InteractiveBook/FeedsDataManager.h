//
//  FeedsDataManager.h
//  testflighthub
//
//  Created by Yi Qin on 3/13/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedsDataManager : NSObject

+(id)sharedManager;

-(void)loadTrendingDataWithPaging;
-(void)loadTrendingDataWithPaging:(int)currentPage
                          success:(void (^)(NSArray *objects, BOOL hasMore))successCompletion
                          failure:(void (^)(NSError *error))failureCompletion;

- (NSArray *) getTrendingObjects;

@end
