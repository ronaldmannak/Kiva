//
//  KIVAWSAPIClient.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVAWSAPIClient.h"

NSString *const kKivaWSAPIBaseURLString = @"https://api.kivaws.org";

@implementation KIVAWSAPIClient

+ (instancetype)sharedClient
{
    static KIVAWSAPIClient *_sharedWSClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedWSClient = [[KIVAWSAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kKivaWSAPIBaseURLString]];
        _sharedWSClient.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"application/json"]];

        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    
                    NSLog(@"Reachability: Not reachable");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    
                    NSLog(@"Reachability: Reachable");
                    break;
                    
                case AFNetworkReachabilityStatusUnknown:
                default:
                    NSLog(@"Reachability: Unknown");
                    break;
            }
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];

        _sharedWSClient.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
//        _sharedWSClient.responseSerializer = ...?
    });
    
    return _sharedWSClient;
}

@end
