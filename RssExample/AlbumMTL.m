//
//  AlbumMTL.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/19.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "AlbumMTL.h"

@interface AlbumMTL () {
    NSString *_sizeOfImage;
}

@end

@implementation AlbumMTL

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    
    if (self == nil) return nil;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    @weakify(self);
    [self.imageArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        @strongify(self);
        if (obj[@"label"]) {
            self.imageUrlString = obj[@"label"];

            _sizeOfImage = obj[@"attributes"][@"height"];
            
            *stop = YES;
        }
    }];
    
    NSString *originFileSize = [NSString stringWithFormat:@"%@x%@", _sizeOfImage, _sizeOfImage];
    NSString *fileSize = [NSString stringWithFormat:@"%dx%d", (int)CGRectGetWidth(screenRect), (int)CGRectGetWidth(screenRect)];
    
    NSRange firstInstance = [self.imageUrlString rangeOfString:originFileSize];

    NSString *part1 = [self.imageUrlString substringToIndex:firstInstance.location];
    NSString *part2 = [self.imageUrlString substringFromIndex:firstInstance.location + originFileSize.length];
    
    self.imageUrlString = [NSString stringWithFormat:@"%@%@%@", part1, fileSize, part2];

    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imageArray": @"im:image",
             @"nameDict": @"im:name",
             @"artistDict": @"im:artist"
             };
}


@end
