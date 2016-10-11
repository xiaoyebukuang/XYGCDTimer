//
//  MyCell.m
//  GCD timer
//
//  Created by cyp on 16/5/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self makeView];
    }
    return self;
}
- (void)makeView{
    UILabel* timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel* messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 100, 40)];
    [self.contentView addSubview:messageLabel];
    self.messageLabel = messageLabel;
}

@end
