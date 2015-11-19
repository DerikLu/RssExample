//
//  AlbumMTL.h
//  RssExample
//
//  Created by Derik Lu on 2015/11/19.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <MTLJSONAdapter.h>
#import <MTLValueTransformer.h>

@interface AlbumMTL : MTLModel<MTLJSONSerializing>


@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSString *imageUrlString;
@property (strong, nonatomic) NSDictionary *nameDict;
@property (strong, nonatomic) NSDictionary *artistDict;

@end
