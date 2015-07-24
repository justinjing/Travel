//
//  CityHeadView.m
//  Travel
//
//  Created by Chinsyo on 15/6/13.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "CityHeadView.h"
#import "UIImageView+WebCache.h"

@implementation CityHeadView

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateUIWithModel:(CityModel *)model
{
    self.cnnameLabel.text=model.cnname;
    self.ennameLabel.text=model.enname;
   
    CGFloat imageWidth=self.scrollView.frame.size.width;
    CGFloat imageHeight=self.scrollView.frame.size.height;
    self.scrollView.contentSize=CGSizeMake(imageWidth*[model.photos count], 0);
    for (int index=0; index<[model.photos count];index++) {
        UIImageView * imageView=[[UIImageView alloc]initWithFrame:(CGRectMake(index*imageWidth, 0, imageWidth, imageHeight))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.photos[index]] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]];
        [self.scrollView addSubview:imageView];
    }
}

//8800~8803
- (IBAction)circleButtonClick:(UIButton *)sender {
    NSArray * categoryIDArray=@[@"32",@"78",@"147",@"148"];
    NSInteger index=sender.tag-8800;
    if (_circleBlock) {
        _circleBlock(categoryIDArray[index]);
    }
}

@end
