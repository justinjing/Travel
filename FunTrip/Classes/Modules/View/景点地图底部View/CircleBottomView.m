//
//  CircleBottomView.m
//  Travel
//
//  Created by Chinsyo on 15/6/18.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "CircleBottomView.h"
#import "UIImageView+WebCache.h"

@implementation CircleBottomView
- (void)initUIWithModel:(CityMapModel *)model
{
    self.cnLabel.text=model.cnname;
    self.enLabel.text=model.enname;
    self.beentoLabel.text=model.beenstr;
    [self.bottomImage sd_setImageWithURL:[NSURL URLWithString:model.photo]];
}

@end
