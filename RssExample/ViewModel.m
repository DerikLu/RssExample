//
//  ViewModel.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/18.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "ViewModel.h"
#import "AlbumMTL.h"

@interface ViewModel () {
    
}

@end

@implementation ViewModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self getAlbum:5];
    }
    
    return self;
}

- (void)getAlbum:(NSInteger)top {
    self.index = top;
    
    [[self.networking getTopAlbum:[NSString stringWithFormat:@"%ld", (long)top]] subscribeNext:^(id x) {
        NSError *err;
        NSArray *array = [MTLJSONAdapter modelsOfClass:[AlbumMTL class] fromJSONArray:x[@"feed"][@"entry"] error:&err];

        self.array = array;
    } error:^(NSError *error) {

    }];
}

- (void)loadMore {
    [self getAlbum:self.index + 10];
}

@end
