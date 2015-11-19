//
//  AlbumLayout.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/19.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "AlbumLayout.h"

@implementation AlbumLayout

- (instancetype)init {
    self = [super init];
    
    if (self) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        self.itemSize = CGSizeMake(CGRectGetWidth(screenRect), CGRectGetWidth(screenRect));
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 邊緣
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 5;
        self.minimumInteritemSpacing = 0;
    }
    
    return self;
}

@end
