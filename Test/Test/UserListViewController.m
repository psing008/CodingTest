//
//  ViewController.m
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import "UserListViewController.h"
#import "UserTableDataDelegate.h"
#import "UserListPageController.h"
#import "UserDetailsViewController.h"
#import "UserEntity.h"
static NSString *const kUserDetailIdentifier= @"userDetailIdentifier";

@interface UserListViewController ()
@property(nonatomic,strong)UserTableDataDelegate *dataSource;
@property(nonatomic,strong)UserListPageController *controller;
@property(nonatomic,strong)NSArray *userListData;
@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userListData = [NSArray new];
    _controller = [[UserListPageController alloc]init];
    self.dataSource = [[UserTableDataDelegate alloc]initWithTableView:self.tableView];
    [self loadUsers];
}

-(void)loadUsers {
    __weak typeof (self) weakSelf = self;
    [self.controller getUserListDataWithBlock:^(NSArray *results, BOOL suces, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //to make sure self is retained throughout
            __typeof__(self) strongSelf = weakSelf;
            strongSelf.userListData = results;
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kUserDetailIdentifier]) {
        UserDetailsViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        UserEntity *entity = self.userListData[indexPath.row];
        [destination.view setValue:entity forKey:@"entity"];
    }
}

-(void)setUserListData:(NSArray *)userListData {
    _userListData = userListData;
    self.dataSource.dataSource = self.userListData;
    [self.dataSource reloadData];
}

@end
