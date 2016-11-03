//
//  IdaTableViewController.m
//  tableView多级展开与折叠
//
//  Created by 腾实信 on 2016/11/1.
//  Copyright © 2016年 ida. All rights reserved.
//

#import "IdaTableViewController.h"

@interface IdaTableViewController ()

@end

@implementation IdaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.itemData = [[ItemData alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.itemData = [[ItemData alloc]init];
    }
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_itemData.tableViewData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%lu",indexPath.row];
    
    IdaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell ==nil) {
        cell = [[IdaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    itemModel *item = [_itemData.tableViewData objectAtIndex:indexPath.row];
    cell.item = item;
    [cell setLevel:item.level];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    IdaTableViewCell *cell = (IdaTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.item.isSubItemOpen) {
        NSArray *arr;
        arr = [_itemData deleteMenuIndexPaths:cell.item];
        if ([arr count]>0) {
            [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
        }
    }
    else{
    
        NSArray *arr;
        arr = [_itemData insertMenuIndexPaths:cell.item];
        if ([arr count]>0) {
            [tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
        }
    }
}

@end
