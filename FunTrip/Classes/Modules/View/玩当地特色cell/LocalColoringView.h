//
//  LocalColoringView.h
//  Travel
//
//  Created by Chinsyo on 15/6/4.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalModel.h"


@interface LocalColoringView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *MainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headOfWriterImageView;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)updateUIWithRecommendModel:(LocalModel *)model;

@end
