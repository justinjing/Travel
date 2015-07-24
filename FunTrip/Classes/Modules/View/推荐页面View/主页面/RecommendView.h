//
//  RecommedView.h
//  Travel
//
//  Created by Chinsyo on 15/6/3.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendModel;
typedef void (^ClickBlock)(RecommendModel * model);

@interface RecommendView : UIView

@property (nonatomic) UICollectionView * collectionView;

- (void)updateRecommendView:(NSMutableArray *)dataArray;

@property (nonatomic, copy) ClickBlock locationClickBlock;

@end
