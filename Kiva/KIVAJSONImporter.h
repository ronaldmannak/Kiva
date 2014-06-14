//
//  KIVAJSONImporter.h
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KIVAJSONImporter : NSObject

- (id)JSONDictionaryFromFileOfEntity:(NSString *)entityName key:(NSString *)key;

@end
