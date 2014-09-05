//
//  BSVimeoAccessRequestCredentials.m
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoRequestCredentials.h"
#import "BSVimeoURLRequest.h"
#import "BSVimeoAccessCredentials.h"
#import "BSVimeoDeveloperCredentials.h"

@interface BSVimeoRequestCredentials ()

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *verifier;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *consumerKey;
@property (nonatomic, copy) NSString *consumerSecret;

@end

@implementation BSVimeoRequestCredentials

- (instancetype)initWithToken:(NSString *)token
                     verifier:(NSString *)verifier
                       secret:(NSString *)secret
                  consumerKey:(NSString *)consumerKey
            andConsumerSecret:(NSString *)consumerSecret {
    
    self = [super init];
    if (self) {
        _token = token;
        _verifier = verifier;
        _secret = secret;
        _consumerKey = consumerKey;
        _consumerSecret = consumerSecret;
    }
    return self;
}

- (BOOL)areValid {
    if (self.token && self.secret && self.verifier) {
        return YES;
    }
    return NO;
}

@end
