//
//  KIVAJSONImporter.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVAJSONImporter.h"

@implementation KIVAJSONImporter


- (id)JSONDictionaryFromFileOfEntity:(NSString *)entityName key:(NSString *)key
{
    NSError *error = nil;
    NSData *fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:entityName ofType:@"json"]];
    NSDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:&error];
    if (error) {
        NSLog(@"Error serializing JSON file %@: %@", [[NSBundle mainBundle] pathForResource:entityName ofType:@"json"], error);
        return nil;
    }
    
    if (key) {
        return ((NSDictionary *)JSONData)[key];
    } else {
        return JSONData;
    }
}

@end
