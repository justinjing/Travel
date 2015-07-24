//
//  CircleButtonCell.h
//  Travel
//
//  Created by Chinsyo on 15/6/15.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryModel.h"

@interface CircleButtonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *beentoCountLabel;

- (void)initUIWithModel:(EntryModel *)model;

@end
