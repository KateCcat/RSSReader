//
//  ESPFeed.m
//  ESPTestRSS
//
//  Created by Admin on 20.12.16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ESPFeed.h"

@implementation ESPFeed

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.titleFeeds = [decoder decodeObjectForKey:@"titleFeeds"];
    self.urlFeeds = [decoder decodeObjectForKey:@"urlFeeds"];
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.titleFeeds forKey:@"titleFeeds"];
    [encoder encodeObject:self.urlFeeds forKey:@"urlFeeds"];
   
}
@end
