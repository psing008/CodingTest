//
//  UserTableDataDelegate.m
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import "UserTableDataDelegate.h"
#import "UserEntity.h"
#import "APIManager.h"
@implementation UserTableDataDelegate
-(instancetype)initWithTableView:(UITableView *)tableView {
    if (self == [super init]) {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier =  @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
-(void)configureCell:(UITableViewCell  *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.imageView.image = nil;
    UserEntity *entity = _dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",entity.firstName,entity.lastname];
    // if cached image, do not fetch image
    if (entity.image) {
        cell.imageView.image = entity.image;
    }else {
        [[APIManager sharedInstance] getImageWithURL:entity.imageURL andBlock:^(UIImage *image, NSError *error) {
            if (error || image == nil) {
                return;
            }
          
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    UITableViewCell *oldCell = [self.tableView cellForRowAtIndexPath:indexPath];
                    // this will give nil, if cell has scrolled off
                    if (oldCell) {
                        oldCell.contentMode = UIViewContentModeCenter;
                        oldCell.imageView.image = image;
                        [oldCell setNeedsLayout];
                    
                    }
                    entity.image = image; // set image so no fetching next time
                }
            });
        }];
    }
}
-(void)reloadData {
    [self.tableView reloadData];
}
@end
