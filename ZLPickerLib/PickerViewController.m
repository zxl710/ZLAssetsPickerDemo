//
//  PickerViewController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#define CELL_ROW 4
#define CELL_MARGIN 5
#define CELL_LINE_MARGIN 5


#import "PickerViewController.h"
#import "PickerCollectionView.h"
#import "PickerDatas.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PickerViewController ()

@property (nonatomic , weak) PickerCollectionView *collectionView;

@end

@implementation PickerViewController


#pragma mark -getter
- (PickerCollectionView *)collectionView{
    if (!_collectionView) {
        
        CGFloat cellW = (self.view.frame.size.width - CELL_MARGIN * CELL_ROW + 1) / CELL_ROW;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellW, cellW);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = CELL_LINE_MARGIN;
        
        PickerCollectionView *collectionView = [[PickerCollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:layout];
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.backgroundColor = [UIColor grayColor];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitle:@"back" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.backgroundColor = [UIColor grayColor];
    customBtn.frame = CGRectMake(280, 0, 40, 40);
    [customBtn setTitle:@"完成" forState:UIControlStateNormal];
    [customBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customBtn];
    
    
    // 获取图片
    [self getImgs];
}

- (void) back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) done{
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerDonePictures:)]) {
        
        [self.delegate pickerViewControllerDonePictures:self.collectionView.selectPictureArray];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",self.collectionView.selectPictureArray);
}

-(void)getImgs{
    
    PickerDatas *datas = [PickerDatas defaultPicker];
    
    // 获取所有的图片URLs
    //    [datas getAllPhotosURLs:^(id obj) {
    //        self.collectionView.dataArray = obj;
    //    }];
    
    [datas getAllPhotosURLs:^(id obj) {
        self.collectionView.dataArray = obj;
    }];
}




@end
