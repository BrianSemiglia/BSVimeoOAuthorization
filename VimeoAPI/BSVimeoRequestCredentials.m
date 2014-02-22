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

@implementation BSVimeoRequestCredentials

- (BOOL)areValid {
    if (self.token && self.secret && self.verifier) {
        return YES;
    }
    return NO;
}

+ (BSVimeoRequestCredentials *)accessRequestCredentialsWithToken:(NSString *)token
                                                          secret:(NSString *)secret
                                                        verifier:(NSString *)verifier
                                                     consumerKey:(NSString *)consumerKey
                                               andConsumerSecret:(NSString *)consumerSecret {
    
    BSVimeoRequestCredentials *credentials = [[BSVimeoRequestCredentials alloc] init];
    credentials.token = token;
    credentials.verifier = verifier;
    credentials.secret = secret;
    credentials.consumerKey = consumerKey;
    credentials.consumerSecret = consumerSecret;
    return credentials;
}

@end
