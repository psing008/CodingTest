//
//  APIManager.h
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserEntity,UIImage;
@interface APIManager : NSObject
+(APIManager *)sharedInstance;
-(void)getDataWithPath:(NSString *)urlPath andBlock:(void (^)(NSArray * , BOOL, NSError* ))completionBlock jsonClass:(Class)JSONbaseClass;
-(void)getImageWithURL:(NSString *)imageURL andBlock:(void (^)(UIImage *,NSError *))completionBlock;
@end
