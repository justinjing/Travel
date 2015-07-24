//
//  HeadViewForDestinationView.m
//  Travel
//
//  Created by Chinsyo on 15/6/6.
//  Copyright (c) 2015年 Chinsyo. All rights reserved.
//亚洲 欧洲  北美 南美 大洋洲  非洲  南极洲
//南极洲会崩溃 因为他的其他城市 是空的
//南美洲会崩溃
//tag  3400~3406

#import "HeadViewForDestinationView.h"

@implementation HeadViewForDestinationView

- (void)awakeFromNib {
    // Initialization code
    _currentButton=(UIButton *)[self viewWithTag:3400];
    _currentButton.selected=YES;
}

- (IBAction)areaChooseButton:(UIButton *)sender
{
    if (sender!=_currentButton) {
        _currentButton.selected=NO;
        _currentButton=sender;
        _currentButton.selected=YES;
        _areaBlock(sender.tag);
    }
}

- (void)updateHeadLabelWithString:(NSString *)string
{
    _headLabel.text=string;
}

@end
