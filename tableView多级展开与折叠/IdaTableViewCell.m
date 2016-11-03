//
//  IdaTableViewCell.m
//  tableView多级展开与折叠
//
//  Created by 腾实信 on 2016/11/1.
//  Copyright © 2016年 ida. All rights reserved.
//

#import "IdaTableViewCell.h"

@implementation IdaTableViewCell

@synthesize item = _item,isOpen = _isOpen;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 30)];
        detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 50, 30)];
        
        [self addSubview:titleLabel];
        [self addSubview:detailLabel];
    }
    return self;
}

-(void)setLevel:(NSUInteger)level{
    if (self.item) {
        titleLabel.text = _item.title;
        if ([_item.subItems count]>0) {
            detailLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_item.subItems.count];
        }
        else{
        
            detailLabel.text = [NSString stringWithFormat:@""];

        }
    
    }
    CGRect rect = titleLabel.frame;
    rect.origin.x = level*20;
    titleLabel.frame = rect;
    
}

@end
