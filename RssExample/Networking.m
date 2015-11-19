//
//  Networking.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/18.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "Networking.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

@interface Networking ()

- (AFHTTPRequestOperationManager *)manager;
- (void)getRequest:(id)subscriber urlString:(NSString *)urlString params:(NSDictionary *)params;

@end

@implementation Networking

+ (Networking *)sharedInstance {
    static Networking *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [Networking new];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    
    return self;
}

- (RACSignal *)getTopAlbum:(NSString *)limit {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/tw/rss/topalbums/limit=%@/json", limit];
        [self getRequest:subscriber urlString:urlString params:nil];
        
        return nil;
    }];
}

#pragma mark - Private
- (AFHTTPRequestOperationManager *)manager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return manager;
}

- (void)getRequest:(id)subscriber urlString:(NSString *)urlString params:(NSDictionary *)params {
    AFHTTPRequestOperationManager *manager = [self manager];
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        [subscriber sendNext:responseObject];
        [subscriber sendCompleted];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [subscriber sendError:error];
    }];
}

@end
