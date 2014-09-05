//
//  BSVimeoAuthorizationCredentials.m
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoAuthorizationCredentials.h"
#import "BSVimeoURLRequest.h"

@interface BSVimeoAuthorizationCredentials ()

@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, copy) NSString *secret;

@end

@implementation BSVimeoAuthorizationCredentials

- (id)initWithURL:(NSURL *)URL
        andSecret:(NSString *)secret {
    
    self = [super init];
    if (self) {
        _URL = URL;
        _secret = secret;
    }
    return self;
}


@end
