//
//  ItemData.h
//  tableView多级展开与折叠
//
//  Created by 腾实信 on 2016/11/1.
//  Copyright © 2016年 ida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "itemModel.h"
#import <UIKit/UIKit.h>

@interface ItemData : NSObject
{
    itemModel *rootItem;
    //折叠  数据源中要删除的数据
    NSMutableArray *treeItemsToRemove;
    //展开  数据源中要删除的数据
    NSMutableArray *treeItemsToInsert;
}
//tableView的数据源
@property(nonatomic,strong)NSMutableArray *tableViewData;
//tableview中要插入的indexPath数组
-(NSArray *)insertMenuIndexPaths:(itemModel*)item;
//tableview中要删除的indexPath数组
-(NSArray *)deleteMenuIndexPaths:(itemModel*)item;
@end
