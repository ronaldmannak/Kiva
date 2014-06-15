//
//  KIVAWSAPIClient.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVAWSAPIClient.h"
#import "KIVAAPIClient.h"

//NSString *const kKivaWSAPIBaseURLString = @"https://api.kivaws.org";
NSString *const kKivaWSAPIBaseURLString = @"http://ec2-54-187-253-179.us-west-2.compute.amazonaws.com:8000";
//http://ec2-54-187-253-179.us-west-2.compute.amazonaws.com:8000/auth/kiva_access/

@interface KIVAWSAPIClient ()
@property (nonatomic, strong) NSString *oAuthToken;
@property (nonatomic, strong) NSString *oAuthSecret;

@end

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

#pragma mark - Feed

- (void)loansOfType:(NSString *)typeString success:(void (^)(NSArray *loans))success
{
    if (!self.oAuthToken) {
        self.oAuthToken = @"WouldYouMindMeSendingAFakeOAuthToken?";
    }
    NSDictionary *parameters = @{
                                 @"token"   : self.oAuthToken,
                                 @"type"    : typeString,
                                 };
    
    [self POST:@"loan_list/"
    parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"response: %@", responseObject);
           if (success) { success(success); }
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           NSLog(@"Fail: %@", error);
           if (success) { success(nil); }
       }];
}

- (void)allLoans:(void (^)(NSArray *loans))success
{
    if (!self.oAuthToken) {
        self.oAuthToken = @"WouldYouMindMeSendingAFakeOAuthToken?";
    }
    
    [self POST:@"all_loans/"
    parameters:@{@"token": self.oAuthToken}
       success:^(NSURLSessionDataTask *task, id responseObject) {
//           NSLog(@"response: %@", responseObject);
           if (success) { success(responseObject); }
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           NSLog(@"Fail: %@", error);
           if (success) { success(nil); }
       }];
}


#pragma mark - Session

- (void)openSession:(void (^)(BOOL success))success
{
    __weak typeof(self) weakSelf = self;
    // 1. Request oAuth Token from AWS
    [self requestoAuthTokenSuccess:^(NSString *oAuthToken, NSString *oAuthSecret) {
        
        // TEMP. Remove these lines once login is fully working
        self.oAuthToken = oAuthToken;
        self.oAuthSecret = oAuthSecret;
        
        // 2. Request verifition code from Kiva.org
        [[KIVAAPIClient sharedClient] requestoAuthTokenSuccess:^(NSString *verificationCode) {
            
            // 3. Login to AWS
            [self openSessionWithOAuthToken:oAuthToken
                                oAuthSecret:oAuthSecret
                                   verifier:verificationCode
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        
                                        // Successful login
                                        weakSelf.oAuthToken = oAuthToken;
                                        weakSelf.oAuthSecret = oAuthSecret;
                                        if (success) { success(YES); }
                                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        if (success) { success(NO); }
                                    }];
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (success) { success(NO); }
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (success) { success(NO); }
    }];
}

- (void)requestoAuthTokenSuccess:(void (^)(NSString *oAuthToken, NSString *oAuthSecret))success
                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSParameterAssert(success);
    [self GET:@"auth/kiva_request/" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *oAuthToken    = responseObject[@"oauth_token"];
        NSString *oAuthSecret   = responseObject[@"oauth_token_secret"];
        if (success) {
            success(oAuthToken, oAuthSecret);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"fail: %@", error);
        if (failure) {failure(task, error);}
    }];
}

- (void)openSessionWithOAuthToken:(NSString *)oAuthToken
                      oAuthSecret:(NSString *)oAuthSecret
                         verifier:(NSString *)verifier
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSParameterAssert(oAuthToken && oAuthSecret && verifier);
    
    
    
    NSDictionary *parameters = @{
                                 @"oauth_token"         : oAuthToken,
                                 @"oauth_token_secret"  : oAuthSecret,
                                 @"verifier"            : verifier
                                 };
    
    [self POST:@"auth/kiva_access/" parameters:parameters
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSLog(@"response: %@", responseObject);
           if (success) {success(task, success);}
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           NSLog(@"fail: %@", error);
           if (failure) {failure(task, error);}
       }];
}

@end
