//
//  KIVADataManager.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVADataManager.h"
#import "KIVALoan.h"
#import "KIVAWSAPIClient.h"

@interface KIVADataManager ()

@property (nonatomic, strong) NSArray   *geographyLoans;
@property (nonatomic, strong) NSArray   *expiringLoans;

@end

@implementation KIVADataManager

+ (instancetype)sharedManager
{
    static KIVADataManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[KIVADataManager alloc] init];
    });
    return _sharedManager;
}

- (void)loansOfType:(KIVALoanType)type success:(void (^)(NSArray *loans))success
{
    NSArray *types = @[@"geography", @"expiring"];
    if (type > types.count - 1) {
        type = KIVALoanTypeExpiring;
    }
    [[KIVAWSAPIClient sharedClient] loansOfType:types[type]
                                        success:^(NSArray *loans) {
                                            NSLog(@"array: %@", loans);
                                        }];
    
}

- (void)allLoanSuccess:(void (^)(NSArray *loans))success
{
    [[KIVAWSAPIClient sharedClient] allLoans:^(NSDictionary *loans) {
        NSLog(@"loans: %@", loans);
    }];
}

@end
