//
//  LocationCollectCell.m
//  Travel
//
//  Created by Chinsyo on 15/6/12.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "LocationCollectCell.h"
#import "UIImageView+WebCache.h"

@implementation LocationCollectCell

- (void)awakeFromNib {
    
}

- (void)updateCollectionCellWithModel:(LocationModel *)model
{
    [ self.imageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
    self.textView.text=model.description;
    self.placeNameLabel.text=model.firstname;
}

- (CGFloat)getCellHeightWithModel:(LocationModel *)model width:(CGFloat)width
{
    CGFloat height=[self heightForString:model.description fontSize:16 andWidth:width];
    return 225+height;
}

#pragma mark

- (float) heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont boldSystemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    self.textView.frame=CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.frame.size.width, deSize.height);
    return deSize.height;
}

@end
