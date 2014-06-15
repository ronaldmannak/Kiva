//
//  KIVAAPIClient.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVAAPIClient.h"

NSString *const kKivaAPIBaseURLString = @"https://www.kiva.org";

@implementation KIVAAPIClient

+ (instancetype)sharedClient
{
    static KIVAAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[KIVAAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kKivaAPIBaseURLString]];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"application/json"]];
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    
                    NSLog(@"Reachability: Kiva.org Not Reachable");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    
                    NSLog(@"Reachability: Kiva.org Reachable");
                    break;
                    
                case AFNetworkReachabilityStatusUnknown:
                default:
                    NSLog(@"Reachability: Kiva.org reachability Unknown");
                    break;
            }
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        _sharedClient.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
        //        _sharedWSClient.responseSerializer = ...?
    });
    
    return _sharedClient;
}

- (void)requestoAuthTokenSuccess:(void (^)(NSString *verificationCode))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    // Todo: RTFM http://build.kiva.org/docs/conventions/oauth
    if (success) {
        success (@"1234");
    }
}

@end
