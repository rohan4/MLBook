//
//  FeedsDataManager.m
//  testflighthub
//
//  Created by Yi Qin on 3/13/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "FeedsDataManager.h"
#import <Parse/Parse.h>
#import <InteractiveBook-Swift.h>
#import "NSParseImage.h"

@interface FeedsDataManager()
@property(nonatomic) int trendingObjectsPerPage;
@property(nonatomic, strong) NSMutableArray *trendingObjects;

@end

@implementation FeedsDataManager

+(id)sharedManager {
    static FeedsDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _trendingObjectsPerPage = 20;
        _trendingObjects = [[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void)loadTrendingDataWithPaging {
    [self loadTrendingDataWithPaging:0 success:^(NSArray *objects, BOOL hasMore) {
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)loadTrendingDataWithPaging:(int)currentPage
                          success:(void (^)(NSArray *objects, BOOL hasMore))successCompletion
                          failure:(void (^)(NSError *error))failureCompletion {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Page"];
    [query whereKey:@"isPublished" equalTo:[NSNumber numberWithBool:NO]];
    [query setLimit:self.trendingObjectsPerPage];
    query.skip = self.trendingObjectsPerPage*currentPage;
    [query orderByDescending:@"pageIndex"];
    [query addDescendingOrder:@"releasedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            failureCompletion(error);
        }
        else {
            NSMutableArray *tempFeeds = [[NSMutableArray alloc] init];
            
            for (PFObject *object in objects){
                Product *page = [[Product alloc] initWithParseObject:object];
                [tempFeeds addObject:page];
            }
            
            BOOL tempHasMore;
            if (objects.count < self.trendingObjectsPerPage) {
                tempHasMore = NO;
            }
            else {
                tempHasMore = YES;
            }
            
            successCompletion([tempFeeds copy], tempHasMore);
        }
    }];
}

- (NSArray *)getTrendingObjects {
    return [self.trendingObjects copy];
}

@end
