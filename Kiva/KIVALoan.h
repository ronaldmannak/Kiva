//
//  KIVALoan.h
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVABaseModel.h"
@import CoreLocation;

//  Loan model documentation: http://build.kiva.org/docs/data/loans
//  Use [MTLJSONAdapter modelOfClass:KIVALoan.class fromJSONDictionary:responseObject error:&error]; to create a new loan instance

@interface KIVALoan : KIVABaseModel

@property (nonatomic, readonly) NSUInteger      loanID;
//@property (nonatomic, readonly) NSDate          *postedDate;
//
//// Details
@property (nonatomic, readonly) NSString        *name;
@property (nonatomic, readonly) NSString        *loanDescription;
@property (nonatomic, readonly) NSString        *longDescription;
@property (nonatomic, readonly) NSString        *activity;     
@property (nonatomic, readonly) NSString        *use;
@property (nonatomic, readonly) NSString        *sector;
@property (nonatomic, readonly) NSURL           *imageURL;
//
//// Location
@property (nonatomic, readonly) NSString        *country;
@property (nonatomic, readonly) NSString        *countryCode;
@property (nonatomic, readonly) NSString        *town;
@property (nonatomic, readonly) CLLocation      *coordinate;
//
//// Status
@property (nonatomic, readonly) double          fundedAmount;
@property (nonatomic, readonly) double          loanAmount;
@property (nonatomic, readonly) double          fundedPercentage;
@property (nonatomic, readonly) NSInteger       partnerID;
@property (nonatomic, readonly) NSString        *loanStatus;
@property (nonatomic, readonly) NSInteger       borrowerCount;


/**
 *  Imports JSON loan data from disk
 */
+ (NSArray *)importLoansFromDisk;

@end
