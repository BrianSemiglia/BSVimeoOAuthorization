//
//  BSVimeoDeveloperCredentials.h
//  VimeoAPI
//
//  Created by Brian on 2/17/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSVimeoDeveloperCredentials : NSObject

@property (nonatomic, readonly, copy) NSString *consumerKey;
@property (nonatomic, readonly, copy) NSString *consumerSecret;

- (instancetype)initWithConsumerKey:(NSString *)consumerKey andConsumerSecret:(NSString *)consumerSecret;

@end
