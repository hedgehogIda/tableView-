//
//  ItemData.m
//  tableView多级展开与折叠
//
//  Created by 腾实信 on 2016/11/1.
//  Copyright © 2016年 ida. All rights reserved.
//

#import "ItemData.h"

@implementation ItemData
@synthesize tableViewData = _tableViewData;
-(instancetype)init{
    self = [super init];
    if (self) {
        self.tableViewData = [NSMutableArray array];
        treeItemsToInsert = [NSMutableArray array];
        treeItemsToRemove = [NSMutableArray array];
        [self initModeData];
        
    }
    return self;
}
-(void)initModeData{

    [self data];
    [self data];
}
-(void)data {
    rootItem = [[itemModel alloc]init];
    rootItem.title = @"根-0";
    rootItem.subItems = [NSMutableArray array];
    rootItem.level = 0;
    
    NSArray *firstListArray = [NSArray arrayWithObjects:@"哈哈哈-0",@"哈哈哈-1",@"哈哈哈-2",@"哈哈哈-3",nil];
    
    NSArray *secondListArray_0 = [NSArray arrayWithObjects:@"哈哈-0",@"哈哈-1",@"哈哈-2",@"哈哈-3", nil];
    NSArray *secondListArray_1 = [NSArray arrayWithObjects:@"haha-0",@"haha-1",@"haha-2",@"haha-3", nil];
    
    NSArray *thirdListArray = [NSArray arrayWithObjects:@"哈-0",@"哈-1",@"哈-2",@"哈-3", nil];
    
    
    for (int i=0; i<[firstListArray count]; i++) {
        
        NSString *title = [firstListArray objectAtIndex:i];
        itemModel *firstModel = [[itemModel alloc]init];
        firstModel.title = title;
        firstModel.subItems = [NSMutableArray array];
        firstModel.level = 1;
        
        if ([title isEqualToString:@"哈哈哈-0"]) {
            
            for (int i=0; i<[secondListArray_0 count]; i++) {
                NSString *title = [secondListArray_0 objectAtIndex:i];
                itemModel *secondItem = [[itemModel alloc]init];
                secondItem.title = title;
                secondItem.subItems = [NSMutableArray array];
                secondItem.level = 2;
                [firstModel.subItems addObject:secondItem];
                
            }
        }
        
        if ([title isEqualToString:@"哈哈哈-3"]) {
            for (int i=0; i<[secondListArray_1 count]; i++) {
                NSString *title = [secondListArray_1 objectAtIndex:i];
                itemModel *secondItem = [[itemModel alloc]init];
                secondItem.title = title;
                secondItem.subItems = [NSMutableArray array];
                secondItem.level =2;
                secondItem.isSubCasecadeOpen = NO;
                if ([title isEqualToString:@"haha-1"]) {
                  
                    for (int i=0; i< [thirdListArray count]; i++) {
                        NSString *title = [thirdListArray objectAtIndex:i];
                        itemModel *thirdItem = [[itemModel alloc]init];
                        thirdItem.title = title;
                        thirdItem.subItems = [NSMutableArray array];
                        thirdItem.level = 3;
                        [secondItem.subItems addObject:thirdItem];
                    }
                }
                
                [firstModel.subItems addObject:secondItem];
            }
        }
        [rootItem.subItems addObject:firstModel];
    }
    
    [_tableViewData addObject:rootItem];
}

#pragma mark - 展开

-(NSArray *)insertMenuIndexPaths:(itemModel*)item{
    
    NSArray *arr;
    [treeItemsToInsert removeAllObjects];
    //tableView的数据源插入数据
    [self insertMenuObject:item];
    //返回插入数据的indexPath数组
    arr = [self insertIndextOfMenuObject:treeItemsToInsert];
    return arr;
    
}
-(void)insertMenuObject:(itemModel*)item{
    
    if (item == nil) {
        return;
    }
    NSIndexPath *path = [NSIndexPath indexPathForRow:[_tableViewData indexOfObject:item] inSection:0];
    
    itemModel *childItem;
    for (int i=0; i<[item.subItems count]; i++) {
        
        childItem = [item.subItems objectAtIndex:i];
        [_tableViewData insertObject:childItem atIndex:path.row+i+1];
        [treeItemsToInsert addObject:childItem];
        item.isSubItemOpen = YES;
    }
    for (int i=0; i<[item.subItems count]; i++) {
        childItem = [item.subItems objectAtIndex:i];
        if (childItem.isSubCasecadeOpen) {
            [self insertMenuObject:childItem];
        }
    }
    return ;
}
-(NSArray *)insertIndextOfMenuObject:(NSMutableArray*)arr{

    NSMutableArray *mutaArray = [NSMutableArray array];
    
    for (itemModel *item in arr) {
        NSIndexPath  *path= [NSIndexPath indexPathForRow:[_tableViewData indexOfObject:item] inSection:0];
        [mutaArray addObject:path];
    }
    
    return mutaArray;
}

#pragma mark - 收起 折叠

-(NSArray *)deleteMenuIndexPaths:(itemModel*)item{

    NSArray *arr;
    [treeItemsToRemove removeAllObjects];
    //更新数据源
    [self deleteMenuObject:item];
    //修改界面
    arr = [self deleteIndexsOfMenuObject:treeItemsToRemove];
    return arr;
}

-(void)deleteMenuObject:(itemModel*)item{

    if (item==nil) {
        return;
    }
    itemModel *childItem;
    for (int i=0; i<[item.subItems count] && item.isSubItemOpen; i++) {
        
        childItem = [item.subItems objectAtIndex:i];
        //递归删除子节点里的数据
        [self deleteMenuObject:childItem];
        [treeItemsToRemove addObject:childItem];
        
    }
    item.isSubItemOpen = NO;
    
}
-(NSArray *)deleteIndexsOfMenuObject:(NSMutableArray*)arr{

    NSMutableArray *mutabelArr= [NSMutableArray array];
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    for (int i=0; i<[treeItemsToRemove count]; i++) {
        itemModel *item = [treeItemsToRemove objectAtIndex:i];
        NSIndexPath *path = [NSIndexPath indexPathForRow:[_tableViewData indexOfObject:item] inSection:0];
        [mutabelArr addObject:path];
        [set addIndex:path.row];
    }
    
    [_tableViewData removeObjectsAtIndexes:set];
    return mutabelArr;
}
@end
