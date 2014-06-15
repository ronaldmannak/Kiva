//
//  KIVAAPIClient.h
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "AFHTTPSessionManager.h"

/*
 Authentication flow:
 1. Login Facebook
 1. Call Amazon URL with FB token (URL in HipChat), receive oAuth token and secret
 2. Use token from Amazon to login to Kiva, returns verification code ( http://build.kiva.org/docs/conventions/oauth )
 3. POST verification code, oauth_token from the first response, oauth_token_secret from the first response to Amazon URL link in Google doc. 
 */

@interface KIVAAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (void)requestoAuthTokenSuccess:(void (^)(NSString *verificationCode))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end
