//
//  UserTableDataDelegate.h
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UserTableDataDelegate : NSObject <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)NSArray *dataSource;
-(instancetype)initWithTableView:(UITableView *)tableView;
-(void)reloadData;
@end
