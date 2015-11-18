//
//  AlbumMTL.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/19.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "AlbumMTL.h"

@implementation AlbumMTL

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imageDict": @"im:image",
             @"nameDict": @"im:name",
             @"artistDict": @"im:artist"
             };
}


@end
