//
//  ISImage.m
//  instaSquare
//
//  Created by Robert Manson on 10/20/13.
//  Copyright (c) 2013 Robert & Sairam. All rights reserved.
//

#import "ISImage.h"

@interface ISImage()

@end

@implementation ISImage

- (instancetype) initWithImageUrl: (NSString*) url
{
    self = [super init];
    
    if (self)
    {
        self.url = url;
    }
    
    return self;
}

+ (NSMutableArray*) imagesFromArray: (NSArray*) dictionaries
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in dictionaries)
    {
        NSMutableDictionary *jsonImage = [dictionary mutableCopy];
        if (jsonImage)
        {
            for (id key in jsonImage.allKeys)
            {
                if ([jsonImage[key] isKindOfClass:[NSNull class]])
                {
                    [jsonImage removeObjectForKey:key];
                }
            }
        }
        NSString* url = jsonImage[@"images"][@"standard_resolution"][@"url"];
        NSString* caption = nil;
        
        if (jsonImage[@"caption"] && jsonImage[@"caption"][@"text"])
        {
            caption = jsonImage[@"caption"][@"text"];
        }
        
        ISImage *image = [[ISImage alloc] initWithImageUrl: url];
        
        if (caption)
        {
            image.caption = caption;
        }
        
        NSString *created = jsonImage[@"created_time"];
        image.dateCreated = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval)[created intValue]];

        image.latitude = [jsonImage[@"location"][@"latitude"] doubleValue];
        image.longitude = [jsonImage[@"location"][@"longitude"] doubleValue];
        
        [array addObject:image];
    }
    return array;
}
@end
