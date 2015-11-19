//
//  Networking.h
//  RssExample
//
//  Created by Derik Lu on 2015/11/18.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networking : NSObject

+ (Networking *)sharedInstance;

- (RACSignal *)getTopAlbum:(NSString *)limit;

@end
