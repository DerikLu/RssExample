//
//  ViewModel.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/18.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "ViewModel.h"
#import "AlbumMTL.h"

@implementation ViewModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self getRss];
    }
    
    return self;
}

- (void)getRss {
    [[self.networking getTopAlbum:@"2"] subscribeNext:^(id x) {
        NSLog(@"x %@", x);
        
        NSError *err;
        NSArray *array = [MTLJSONAdapter modelsOfClass:[AlbumMTL class] fromJSONArray:x[@"feed"][@"entry"] error:&err];
        NSLog(@"arr  %@, err %@", array, err);
    } error:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}

@end
