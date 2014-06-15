//
//  KIVAWSAPIClient.h
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface KIVAWSAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)openSession:(void (^)(BOOL success))success;

- (void)loansOfType:(NSString *)typeString
            success:(void (^)(NSArray *loans))success;

- (void)allLoans:(void (^)(NSDictionary *loans))success;

@end
