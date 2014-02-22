//
//  BSVimeoAuthorizationCredentials+Adapter.m
//  VimeoAPI
//
//  Created by Brian on 2/17/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoAuthorizationCredentials+Adapter.h"
#import "BSVimeoDeveloperCredentials.h"

@implementation BSVimeoAuthorizationCredentials (Adapter)

+ (void)authorizationCredentialsWithDeveloperCredentials:(BSVimeoDeveloperCredentials *)developerCredentials
                                    andCompletionHandler:(void (^)(BSVimeoAuthorizationCredentials *credentials))completionHandler {
    
    [self authorizationCredentialsWithConsumerKey:developerCredentials.consumerKey
                                   consumerSecret:developerCredentials.consumerSecret
                             andCompletionHandler:completionHandler];
}

@end
