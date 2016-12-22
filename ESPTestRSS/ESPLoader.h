//
//  ESPLoader.h
//  ESPTestRSS
//
//  Created by Admin on 18.12.16.
//  Copyright © 2016 Test. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ESPLoaderDelegate <NSObject>

-(void) handleRssArray: (NSArray*) array withTitle: (NSString*) title;

@end

@interface ESPLoader : NSObject
@property (nonatomic, weak) id <ESPLoaderDelegate> delegate;

-(void) startLoading;

@end
