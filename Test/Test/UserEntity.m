//
//  UserEntity.m
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity
-(instancetype)init {
    if (self == [super init]) {
        _userName = [NSString new];
        _firstName = [NSString new];
        _lastname = [NSString new];
        _imageURL = [NSString new];
        _largeImageURL = [NSString new];
    }
    return self;
    
}
-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self == [super init]) {
        if ([dict objectForKey:@"name"]) {
            NSDictionary *name = [dict valueForKey:@"name"];
            _firstName  = [NSString stringWithString:[name valueForKey:@"first"]];
            _lastname = [NSString stringWithString:[name valueForKey:@"last"]];
            
            if ([dict objectForKey:@"picture"]) {
                NSDictionary *picture = [dict valueForKey:@"picture"];
                _imageURL = [NSString stringWithString:[picture valueForKey:@"thumbnail"]];
                _largeImageURL = [NSString stringWithString:[picture valueForKey:@"large"]];

            }
        }
    }
    return self;
}


@end
