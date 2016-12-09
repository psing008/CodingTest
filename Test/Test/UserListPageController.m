//
//  UserListPageController.m
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import "UserListPageController.h"
#import "APIManager.h"
#import "UserEntity.h"

static NSString * const userListURLString = @"https://randomuser.me/api/?results=100";
@implementation UserListPageController
-(instancetype)init {
    if (self == [super init]) {
        
    }
    return self;
}


-(void)getUserListDataWithBlock:(void (^)(NSArray *, BOOL, NSError *))completionBlock {
    
    [[APIManager sharedInstance] getDataWithPath:userListURLString andBlock:^(NSArray *results, BOOL sucess, NSError *error) {
        completionBlock(results,sucess,error);
    } jsonClass:[UserEntity class]];
}
@end
