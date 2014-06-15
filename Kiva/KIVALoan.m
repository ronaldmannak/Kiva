//
//  KIVALoan.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVALoan.h"
#import "KIVAJSONImporter.h"

@implementation KIVALoan

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"loanID"          : @"id",
//             @"postedDate"      : @"posted_date",
             
             @"name"            : @"name",
//             @"loanDescription"     : @"description",
             @"activity"        : @"activity",
             @"use"             : @"use",
             @"sector"          : @"sector",
//             @"imageURL"        : @"image",
             
//             @"country"         : @"posts_count",
//             @"town"            : @"next_anonymous_post_in",
//             @"coordinate"      : @"description",

             @"fundedAmount"    : @"website",
             @"loanAmount"      : @"is_admin",
             @"partnerID"       : @"remaining_down_votes",
             @"loanStatus"      : @"phone_verified",
             @"borrowerCount"   : @"school_id",
             };
};

// Omits null values when model is transformed to a dictionary
// http://stackoverflow.com/questions/18961622/how-to-omit-null-values-in-json-dictionary-using-mantle/19227457#19227457
- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *modifiedDictionaryValue = [[super dictionaryValue] mutableCopy];
    
    for (NSString *originalKey in [super dictionaryValue]) {
        if ([self valueForKey:originalKey] == nil) {
            [modifiedDictionaryValue removeObjectForKey:originalKey];
        }
    }
    return [modifiedDictionaryValue copy];
}

+ (NSValueTransformer *)imageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

/*
+ (NSValueTransformer *)loanStatusJSONTransformer
{
    NSDictionary *states = @{
                             @"fundraising"     : @(KIVALoanStatusFundraising),
                             @"funded"          : @(KIVALoanStatusFunded),
                             @"in_repayment"    : @(KIVALoanStatusInRepayment),
                             @"paid"            : @(KIVALoanStatusPaid),
                             @"defaulted"       : @(KIVALoanStatusDefaulted),
                             @"refunded"        : @(KIVALoanStatusRefunded),
                             };
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return states[str];
    } reverseBlock:^(NSNumber *state) {
        return [states allKeysForObject:state].lastObject;
    }];
}
 */

+ (void)importLoansFromDisk
{
    KIVAJSONImporter *importer = [KIVAJSONImporter new];
    NSDictionary *loans = [importer JSONDictionaryFromFileOfEntity:@"Loan" key:@"loans"];
    for (NSDictionary *loanJSON in loans) {
        NSError *error = nil;
        KIVALoan *loan = [MTLJSONAdapter modelOfClass:KIVALoan.class
                  fromJSONDictionary:loanJSON
                               error:&error];
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@", loan);
        }
    }
}
@end
