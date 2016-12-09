//
//  APIManager.m
//  Test
//
//  Created by Piyush Singh on 12/8/16.
//  Copyright © 2016 Piyush Singh. All rights reserved.
//

#import "APIManager.h"
#import "JSONBaseClass.h"
#import <UIKit/UIKit.h>
static APIManager *_sharedInstance;

@interface APIManager()
@property(nonatomic,strong)NSURLSession *urlSession;
@end

@implementation APIManager
+(APIManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[APIManager alloc]init];
    });
    return _sharedInstance;
}
-(instancetype)init {
    if (self == [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config.HTTPAdditionalHeaders setValue:@"application/json" forKey:@"Content-Type"];
        [config.HTTPAdditionalHeaders setValue:@"application/json" forKey:@"Accept"];
        _urlSession = [NSURLSession sessionWithConfiguration:config];
        
    }
    return self;
}
-(void)getDataWithPath:(NSString *)urlPath andBlock:(void (^)(NSArray *, BOOL, NSError *))completionBlock jsonClass:(__unsafe_unretained Class)JSONbaseClass {
    if (!completionBlock) {
        return;
    }
    
    NSString *urlString = [urlPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            completionBlock(nil,NO,error);
            return;
        }
        
        
        NSError *jsonError;
        id  results  = [APIManager parseData:data andError:&error];
        
        if (jsonError) {
            completionBlock(nil,NO,jsonError);
            return;
        }
        
        NSMutableArray *userDataEntityList = [NSMutableArray new];
        
        NSArray *resultsDict = [results valueForKey:@"results"];
        
        for(NSDictionary *user in resultsDict) {
            JSONBaseClass *userEntity = [[JSONbaseClass alloc] initWithDictionary:user];
            [userDataEntityList addObject:userEntity];
        }
        
        completionBlock([NSArray arrayWithArray:userDataEntityList],YES,nil);
    }];
    
    [dataTask resume];
    
}

-(void)getImageWithURL:(NSString *)imageURL andBlock:(void (^)(UIImage *,NSError *))completionBlock {
    
    NSURLSessionTask *downloadImageTask = [self.urlSession dataTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //crash if no block
        if (!completionBlock) {
            return;
        }
        if (error) {
            completionBlock(nil,error);
            return;
        }
        
        NSError *imageError;
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                completionBlock(image,nil);
            }else{
                //image parsing failed
                imageError = [NSError errorWithDomain:@"ImageParsingFail" code:999 userInfo:nil];
                completionBlock(nil,imageError);
            }
        }
    }];
    [downloadImageTask resume];
}

+(id)parseData:(NSData *)data andError:(NSError * __autoreleasing *)error {
    
    NSError *jsonError;
    id results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
    
    if (jsonError) {
        *error = [NSError errorWithDomain:@"JSONFail" code:1000 userInfo:nil];
    }
    
    return results;
    
}

@end
