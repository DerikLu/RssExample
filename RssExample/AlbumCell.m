//
//  AlbumCell.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/19.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "AlbumCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface AlbumCell() {
    UILabel *_albumArtistLabel;
    UILabel *_albumLabel;
    UIImageView *_albumImageView;

    AlbumMTL *_album;
}

- (void)showData;

@end

@implementation AlbumCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _albumImageView = [UIImageView new];
        [self.contentView addSubview:_albumImageView];
        [_albumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(@0);
        }];
        
        _albumLabel = [UILabel new];
        _albumLabel.backgroundColor = [UIColor clearColor];
        _albumLabel.textColor = [UIColor whiteColor];
        _albumLabel.numberOfLines = 0;
        _albumLabel.textAlignment = NSTextAlignmentCenter;
        _albumLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_albumLabel];
        [_albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.and.bottom.equalTo(@0);
        }];
    }
    
    return self;
}

- (void)setAlbum:(AlbumMTL *)album {
    _album = album;
    
    [self showData];
}

- (void)showData {
    _albumLabel.text = [NSString stringWithFormat:@"%@ (%@)", _album.nameDict[@"label"], _album.artistDict[@"label"]];
    [_albumImageView setImageWithURL:[NSURL URLWithString:_album.imageUrlString] placeholderImage:[UIImage imageNamed:@"img512"]];
}

@end
