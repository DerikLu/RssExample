//
//  ViewModel.h
//  RssExample
//
//  Created by Derik Lu on 2015/11/18.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "SuperViewModel.h"

@interface ViewModel : SuperViewModel

@property (strong, nonatomic) NSArray *array;

- (void)getAlbum:(NSInteger)top;

- (void)loadMore;

@end
