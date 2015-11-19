//
//  ViewController.m
//  RssExample
//
//  Created by Derik Lu on 2015/11/18.
//  Copyright © 2015年 Derik Lu. All rights reserved.
//

#import "ViewController.h"
#import "AlbumMTL.h"
#import "AlbumCell.h"
#import "AlbumLayout.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    UICollectionView *_collectionView;
}

@end

@implementation ViewController

@dynamic viewModel;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.viewModel = [ViewModel new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor blackColor];
    
    @weakify(self);
    
    UIButton *btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnItem setFrame:CGRectMake(0, 0, 40, 40)];
    [btnItem.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [btnItem setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [btnItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnItem];
    [[btnItem rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Top Ablum" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"Input number";
            textField.keyboardType = UIKeyboardTypePhonePad;
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = controller.textFields[0];
            [self.viewModel getAlbum:[textField.text integerValue]];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        
        [controller addAction:cancelAction];
        [controller addAction:okAction];

        [self presentViewController:controller animated:YES completion:nil];
    }];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[AlbumLayout new]];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[AlbumCell class] forCellWithReuseIdentifier:@"CELL"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.and.right.equalTo(@0);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    UICollectionView *collectionView = _collectionView;
    @weakify(collectionView);
    [[[RACObserve(_collectionView, contentOffset) filter:^BOOL(id x) {
        @strongify(collectionView);
        CGPoint offset = [x CGPointValue];
        
        BOOL isNeedLoad = (((offset.y + CGRectGetHeight(collectionView.frame)) / collectionView.contentSize.height) > 0.8 && collectionView.contentSize.height) > 0;
        
        return isNeedLoad;
    }] throttle:0.1] subscribeNext:^(id x) {
        [self.viewModel loadMore];
    }];
    
    [RACObserve(self.viewModel, array) subscribeNext:^(id x) {
        @strongify(collectionView);
        [collectionView reloadData];
    }];
    
    [RACObserve(self.viewModel, index) subscribeNext:^(id x) {
        @strongify(self);
        self.title = [NSString stringWithFormat:@"Top %@ ", x];
    }];
}

#pragma mark - UICollectionView Datasource & Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    AlbumMTL *album = (AlbumMTL *)self.viewModel.array[indexPath.row];
    
    [cell setAlbum:album];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
