//
//  BSVimeoAccessCredentials+Adapter.m
//  VimeoAPI
//
//  Created by Brian on 2/18/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoAccessCredentials+Adapter.h"
#import "BSVimeoDeveloperCredentials.h"
#import "BSVimeoURLRequest.h"

@implementation BSVimeoAccessCredentials (Adapter)

+ (void)getAccessTokenWithRequestCredentials:(BSVimeoRequestCredentials *)requestCredentials
                        andCompletionHandler:(void (^)(BSVimeoAccessCredentials *))completionHandler {
    
    [self getAccessCredentialsWithToken:requestCredentials.token
                                 secret:requestCredentials.secret
                            consumerKey:requestCredentials.consumerKey
                         consumerSecret:requestCredentials.consumerSecret
                               verifier:requestCredentials.verifier
                   andCompletionHandler:completionHandler];
}

+ (NSURLRequest *)methodURLRequestWithAccessCredentials:(BSVimeoAccessCredentials *)accessCredentials
                                          andParameters:(NSDictionary *)parameters {
    NSURLRequest *request = [BSVimeoURLRequest URLRequestWithPath:self.methodPath
                                                       parameters:parameters
                                                            token:accessCredentials.token
                                                           secret:accessCredentials.secret
                                                      consumerKey:accessCredentials.consumerKey
                                                   consumerSecret:accessCredentials.consumerSecret];
    return request;
}

+ (NSString *)methodPath {
    return @"/api/rest/v2";
}

+ (BSVimeoAccessCredentials *)credentialsFromURLEncodedString:(NSString *)string
                                      andDeveloperCredentials:(BSVimeoDeveloperCredentials *)developerCredentials {
    
    NSString *token = [BSVimeoURLRequest tokenFromURLEncodedString:string];
    NSString *secret = [BSVimeoURLRequest secretFromURLEncodedString:string];
    BSVimeoAccessCredentials *credentials = [[BSVimeoAccessCredentials alloc] initWithToken:token secret:secret consumerKey:developerCredentials.consumerKey andConsumerSecret:developerCredentials.consumerSecret];
    return credentials;
}

@end
