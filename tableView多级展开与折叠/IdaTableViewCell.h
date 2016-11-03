//
//  IdaTableViewCell.h
//  tableView多级展开与折叠
//
//  Created by 腾实信 on 2016/11/1.
//  Copyright © 2016年 ida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemModel.h"
@interface IdaTableViewCell : UITableViewCell
{
    
    UILabel *titleLabel;
    UILabel *detailLabel;

}
@property(nonatomic,strong)itemModel *item;
@property(nonatomic)BOOL isOpen;
-(void)setLevel:(NSUInteger)level;
@end
