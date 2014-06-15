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
             @"postedDate"      : @"posted_date",
             
             @"name"            : @"borrower_name",
             @"loanDescription" : @"short_description",
             @"longDescription" : @"long_description",
             @"activity"        : @"activity",
             @"use"             : @"use",
             @"sector"          : @"sector",
             @"imageID"         : @"image_id",
             @"largeImageURL"   : @"large_image_url",
             @"smallImageURL"   : @"short_image_url",
             @"flagURL"         : @"flag_url",

             @"country"         : @"country",
             @"countryCode"     : @"country_code",
             @"town"            : @"town",
             @"coordinate"      : @"coordinate",

             @"fundedAmount"    : @"funded_amount",
             @"loanAmount"      : @"loan_amount",
             @"fundedPercentage": @"funded_percentage",
             @"partnerID"       : @"partner_id",
             @"partnerRating"   : @"partner_rating",
             @"loanStatus"      : @"status",
             @"borrowerCount"   : @"borrower_count",
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

#pragma mark - Core Data
// See MTLManagedObjectAdapter.h

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{
             @"loanID"          : @"loanID",
             @"postedDate"      : @"postedDate",
             
             @"name"            : @"name",
             @"loanDescription" : @"loanDescription",
             @"activity"        : @"activity",
             @"use"             : @"use",
             @"sector"          : @"sector",
             @"imageURL"        : @"imageURL",

             @"country"         : @"country",
             @"town"            : @"town",
             @"coordinate"      : @"coordinate",
             
             @"fundedAmount"    : @"website",
             @"loanAmount"      : @"is_admin",
             @"partnerID"       : @"remaining_down_votes",
             @"loanStatus"      : @"phone_verified",
             @"borrowerCount"   : @"school_id",
             };
}

+ (NSString *)managedObjectEntityName
{
    return @"Loan";
}

+ (NSSet *)propertyKeysForManagedObjectUniquing
{
    return [NSSet setWithObject:@"loanID"];
}

//+ (NSDictionary *)relationshipModelClassesByPropertyKey
//{
//    return @{@"partnerID"     : @"KIVAPartner"}; //[KIVAPartner class]?
//}

#pragma mark - Database import

+ (NSArray *)importLoansFromDisk
{
    KIVAJSONImporter *importer = [KIVAJSONImporter new];
    NSDictionary *loans = [importer JSONDictionaryFromFileOfEntity:@"Loan" key:nil];
    NSMutableArray *loanArray = [NSMutableArray new];
    for (NSDictionary *loanJSON in loans) {
        NSError *error = nil;
        KIVALoan *loan = [MTLJSONAdapter modelOfClass:KIVALoan.class
                  fromJSONDictionary:loanJSON
                               error:&error];
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            [loanArray addObject:loan];
//            NSLog(@"Success: %@", loan);
        }
    }
    return [loanArray copy];
}
@end
