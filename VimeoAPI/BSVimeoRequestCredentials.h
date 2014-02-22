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

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *verifier;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *consumerKey;
@property (nonatomic, copy) NSString *consumerSecret;

- (BOOL)areValid;

@end
