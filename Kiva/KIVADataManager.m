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
    [[KIVAWSAPIClient sharedClient] allLoans:^(NSArray *loans) {

        NSMutableArray *allLoans = [NSMutableArray new];
        for (NSDictionary *JSONDict in loans) {
            NSMutableArray *namedLoans = [NSMutableArray new];
            for (NSDictionary *JSONLoan in JSONDict[@"loans"]) {
                
                NSError *error = nil;
                KIVALoan *loan = [MTLJSONAdapter modelOfClass:KIVALoan.class
                                           fromJSONDictionary:JSONLoan
                                                        error:&error];
                if (error) {
                    NSLog(@"Error: %@", error);
                } else {
                    [namedLoans addObject:loan];
                    [allLoans addObject:loan];
                }
            }
            NSString *name = ((NSArray *)JSONDict[@"name"]).firstObject;            
            if ([name isEqualToString:@"geography"]) {
                self.geographyLoans = namedLoans.copy;
            } else if ([name isEqualToString:@"expiring"]) {
                self.expiringLoans = namedLoans.copy;
            }
        }
        self.allLoans = allLoans.copy;
    }];
}

- (void)loansFromDisk
{
    self.geographyLoans = self.expiringLoans = self.allLoans = [KIVALoan importLoansFromDisk];
}

@end
