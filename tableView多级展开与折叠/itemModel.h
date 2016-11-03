//
//  dataModel.h
//  tableView多级展开与折叠
//
//  Created by 腾实信 on 2016/11/1.
//  Copyright © 2016年 ida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface itemModel : NSObject
@property(nonatomic,copy)NSString *title;
//根据这个level 判断数据在树中的深度 然后设置标题前端的间距
@property(nonatomic)NSInteger level;
@property(nonatomic,strong)NSMutableArray *subItems;
@property(nonatomic)BOOL isSubItemOpen;
@property(nonatomic)BOOL isSubCasecadeOpen;
@end
