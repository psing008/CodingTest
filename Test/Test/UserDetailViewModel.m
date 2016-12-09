//
//  UserDetailViewModel.m
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import "UserDetailViewModel.h"
#import "UserEntity.h"
#import "APIManager.h"
@implementation UserDetailViewModel
-(void)setEntity:(UserEntity *)entity {
    _entity = entity;
    [[APIManager sharedInstance] getImageWithURL:_entity.largeImageURL andBlock:^(UIImage *image, NSError *error) {
        if (error) {
            //Show Error Banner
            return;
        }
        if (image) {
            self.userImage.image = image;
        }
    }];
    self.nameLabel.text  = [NSString stringWithFormat:@"%@ %@",_entity.firstName,entity.lastname];
}

-(void)dealloc {
    
}
@end
