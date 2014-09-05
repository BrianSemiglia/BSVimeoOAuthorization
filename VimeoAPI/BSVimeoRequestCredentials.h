//
//  BSVimeoAccessRequestCredentials.h
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSVimeoDeveloperCredentials;
@class BSVimeoAccessCredentials;

@interface BSVimeoRequestCredentials : NSObject

@property (nonatomic, readonly, copy) NSString *token;
@property (nonatomic, readonly, copy) NSString *verifier;
@property (nonatomic, readonly, copy) NSString *secret;
@property (nonatomic, readonly, copy) NSString *consumerKey;
@property (nonatomic, readonly, copy) NSString *consumerSecret;

- (instancetype)initWithToken:(NSString *)token
                     verifier:(NSString *)verifier
                       secret:(NSString *)secret
                  consumerKey:(NSString *)consumerKey
            andConsumerSecret:(NSString *)consumerSecret;

- (BOOL)areValid;

@end
