//
//  BSVimeoCredentials.h
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSVimeoAccessCredentials : NSObject <NSCoding>

@property (nonatomic, readonly, copy) NSString *token;
@property (nonatomic, readonly, copy) NSString *secret;
@property (nonatomic, readonly, copy) NSString *consumerKey;
@property (nonatomic, readonly, copy) NSString *consumerSecret;

- (BOOL)areValid;

- (instancetype)initWithToken:(NSString *)token
                       secret:(NSString *)secret
                  consumerKey:(NSString *)consumerKey
            andConsumerSecret:(NSString *)consumerSecret;

@end
