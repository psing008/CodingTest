//
//  UserListPageController.h
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONBaseClass.h"
@interface UserListPageController : NSObject
-(void)getUserListDataWithBlock:(void (^)(NSArray *,BOOL, NSError *))completionBlock;
@end
