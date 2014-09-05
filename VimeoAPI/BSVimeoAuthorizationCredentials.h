//
//  BSVimeoAuthorizationCredentials.h
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSVimeoAuthorizationCredentials : NSObject

@property (nonatomic, readonly, copy) NSURL *URL;
@property (nonatomic, readonly, copy) NSString *secret;

- (id)initWithURL:(NSURL *)URL andSecret:(NSString *)secret;

@end
