//
//  DesCountryHeadView.m
//  Travel
//
//  Created by Chinsyo on 15/6/13.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//

#import "DesCountryHeadView.h"
#import "UIImageView+WebCache.h"

@implementation DesCountryHeadView

//四个按钮tag 7800~7803
- (void)awakeFromNib {
    // Initialization code
}

- (void)updateUIWithModel:(DesCountryModel *)model
{
    self.cnnameLabel.text=model.cnname;
    self.ennameLabel.text=model.enname;
    [self addImageToScrollViewWithArray:model.photos];
}

- (void)addImageToScrollViewWithArray:(NSArray *)array
{
    CGFloat width=self.scrollView.frame.size.width;
    CGFloat height=self.scrollView.frame.size.height;
    self.scrollView.contentSize=CGSizeMake(width*array.count, 0);
    for (int index = 0; index < array.count; index++) {
        CGRect frame = CGRectMake(index*width, 0, width, height);
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array[index]] placeholderImage:[UIImage imageNamed:@"zbg_p9_cover_def_mid_round_corner.9.png"]
        ];
        [self.scrollView addSubview:imageView];
    }
    [self insertSubview:self.backgroundView aboveSubview:self.scrollView];
}

- (IBAction)buttonClick:(UIButton *)sender {
    
}

@end
