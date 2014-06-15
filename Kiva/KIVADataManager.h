//
//  KIVADataManager.h
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KIVALoanType) {
    KIVALoanTypeGeography,
    KIVALoanTypeExpiring,
};

@interface KIVADataManager : NSObject

+ (instancetype)sharedManager;

- (void)loansOfType:(KIVALoanType)type
            success:(void (^)(NSArray *loans))success;
- (void)allLoanSuccess:(void (^)(NSArray *loans))success;
@end
