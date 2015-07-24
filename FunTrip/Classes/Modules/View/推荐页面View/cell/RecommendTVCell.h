//
//  RecommendTVCell.h
//  Travel
//
//  Created by Chinsyo on 15/6/11.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendCellModel.h"

@interface RecommendTVCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

- (void)updateCellWithModel:(RecommendCellModel *)model;

@end
