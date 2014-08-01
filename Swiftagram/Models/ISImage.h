//
//  ISImage.h
//  instaSquare
//
//  Created by Robert Manson on 10/20/13.
//  Copyright (c) 2013 Robert & Sairam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISImage : NSObject

@property(nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* caption;
@property (nonatomic, strong) NSDate* dateCreated;
@property (atomic, assign) double latitude;
@property (atomic, assign) double longitude;


+ (NSMutableArray*) imagesFromArray: (NSArray*) dictionaries;

- (instancetype) initWithImageUrl: (NSString*) url;
@end
