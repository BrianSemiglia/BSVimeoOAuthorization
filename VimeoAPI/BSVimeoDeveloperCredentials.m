//
//  BSVimeoDeveloperCredentials.m
//  VimeoAPI
//
//  Created by Brian on 2/17/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoDeveloperCredentials.h"

@interface BSVimeoDeveloperCredentials ()

@property (nonatomic, copy) NSString *consumerKey;
@property (nonatomic, copy) NSString *consumerSecret;

@end

@implementation BSVimeoDeveloperCredentials

- (instancetype)initWithConsumerKey:(NSString *)consumerKey andConsumerSecret:(NSString *)consumerSecret {
    self = [super init];
    if (self) {
        _consumerKey = consumerKey;
        _consumerSecret = consumerSecret;
    }
    return self;
}

@end
