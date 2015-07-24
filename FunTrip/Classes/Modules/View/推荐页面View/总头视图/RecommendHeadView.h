//
//  RecommendHeadView.h
//  Travel
//
//  Created by Chinsyo on 15/6/3.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendHeadView :UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *SubjiectView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

- (void)updateRecommendHeadView:(NSMutableArray *)dataArray;

@end

