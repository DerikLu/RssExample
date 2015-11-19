//
//  SuperViewModel.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/18.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "SuperViewModel.h"

@implementation SuperViewModel

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.networking = [Networking sharedInstance];
    }
    
    return self;
}

@end