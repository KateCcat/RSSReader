//
//  ESPLoader.m
//  ESPTestRSS
//
//  Created by Admin on 18.12.16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ESPLoader.h"
#import <AFNetworking/AFNetworking.h>
#import <XMLDictionary/XMLDictionary.h>
#import "ESPFeed.h"

@implementation ESPLoader

-(void) startLoading  {
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"feedsArray"];
    NSArray* feedsArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if ( ! feedsArray) {
        ESPFeed *feed = [[ESPFeed alloc] init];
        feed.titleFeeds = @"Lenta";
        feed.urlFeeds = @"https://lenta.ru/rss/news";
        feedsArray = @[feed];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:feedsArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"feedsArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    for (ESPFeed* feed in feedsArray) {
        [self loadRssFromFeed:feed.urlFeeds];
    }
    
    NSLog(@"startLoading");
    
   }

-(void) loadRssFromFeed: (NSString*) urlString
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager setResponseSerializer:[AFXMLParserResponseSerializer new]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/rss+xml",@"text/html",@"text/xml",nil];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary* allNews = [NSDictionary dictionaryWithXMLParser:(NSXMLParser*) responseObject];
        //  NSLog(@"Dict %@",allNews);
        if ([allNews objectForKey:@"channel"] && [[allNews objectForKey:@"channel"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary* channel = [allNews objectForKey:@"channel"];
            NSString* channelTitle;
            if ([channel objectForKey:@"title"] && [[channel objectForKey:@"title"] isKindOfClass:[NSString class]]) {
                channelTitle = [channel objectForKey:@"title"];
                
            }
            if ([channel objectForKey:@"item"] && [[channel objectForKey:@"item"] isKindOfClass:[NSArray class]]) {
                NSArray* items = [channel objectForKey:@"item"];
                
                [self.delegate handleRssArray:items withTitle:channelTitle];
            }
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

@end
