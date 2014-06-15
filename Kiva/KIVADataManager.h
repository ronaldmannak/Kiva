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

@property (nonatomic, strong) NSArray   *geographyLoans;
@property (nonatomic, strong) NSArray   *expiringLoans;
@property (nonatomic, strong) NSArray   *allLoans;


+ (instancetype)sharedManager;

- (void)loansOfType:(KIVALoanType)type
            success:(void (^)(NSArray *loans))success;
- (void)allLoanSuccess:(void (^)(NSArray *loans))success;

/**
 *  Only call loansFromDisk when server does not
 *  return data. All loan arrays in KIVADataManager will
 *  be set to the default loans on disk
 */
- (void)loansFromDisk;
@end
