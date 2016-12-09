//
//  UserEntity.h
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSONBaseClass.h"
@interface UserEntity : JSONBaseClass
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *firstName;
@property(nonatomic,copy)NSString *lastname;
@property(nonatomic,copy)NSString *imageURL;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,copy)NSString *largeImageURL;

@end
