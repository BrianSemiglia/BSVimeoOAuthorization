//
//  BSVimeoAuthorizationCredentials+Adapter.m
//  VimeoAPI
//
//  Created by Brian on 2/17/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoAuthorizationCredentials+Adapter.h"
#import "BSVimeoDeveloperCredentials.h"
#import "BSVimeoURLRequest.h"

@implementation BSVimeoAuthorizationCredentials (Adapter)

+ (BSVimeoAuthorizationCredentials *)credentialsFromURLEncodedString:(NSString *)URLEncodedString {
    NSURL *URL = [BSVimeoAuthorizationCredentials userAuthorizationURLFromURLEncodedString:URLEncodedString];
    NSString *secret = [BSVimeoURLRequest secretFromURLEncodedString:URLEncodedString];
    BSVimeoAuthorizationCredentials *credentials = [[BSVimeoAuthorizationCredentials alloc] initWithURL:URL andSecret:secret];
    return credentials;
}

+ (NSURL *)userAuthorizationURLFromURLEncodedString:(NSString *)URLEncodedString {
    NSString *token = [BSVimeoURLRequest tokenFromURLEncodedString:URLEncodedString];
    NSURL *URL = [self userAuthorizationURLWithRequestToken:token];
    return URL;
}

+ (NSURL *)userAuthorizationURLWithRequestToken:(NSString *)token {
    NSString *URLString = [NSString stringWithFormat:@"https://vimeo.com/oauth/authorize?oauth_token=%@&permission=write", token];
    NSURL *userAuthorizationURL = [[NSURL alloc] initWithString:URLString];
    return userAuthorizationURL;
}

+ (void)authorizationCredentialsWithDeveloperCredentials:(BSVimeoDeveloperCredentials *)developerCredentials
                                    andCompletionHandler:(void (^)(BSVimeoAuthorizationCredentials *credentials))completionHandler {
    
    [self authorizationCredentialsWithConsumerKey:developerCredentials.consumerKey
                                   consumerSecret:developerCredentials.consumerSecret
                             andCompletionHandler:completionHandler];
}

+ (void)authorizationCredentialsWithConsumerKey:(NSString *)consumerKey
                                 consumerSecret:(NSString *)consumerSecret
                           andCompletionHandler:(void (^)(BSVimeoAuthorizationCredentials *authorizationCredentials))completionHandler {
    
    void (^dataTaskCompletionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *stringReponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        BSVimeoAuthorizationCredentials *credentials = [BSVimeoAuthorizationCredentials credentialsFromURLEncodedString:stringReponse];
        completionHandler(credentials);
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *requestTokenURLRequest = [self requestTokenURLRequestWithConsumerKey:consumerKey consumerSecret:consumerSecret];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestTokenURLRequest completionHandler:dataTaskCompletionHandler];
    [dataTask resume];
}

+ (NSURLRequest *)requestTokenURLRequestWithConsumerKey:(NSString *)consumerKey
                                         consumerSecret:(NSString *)consumerSecret {
    
    NSURLRequest *request = [BSVimeoURLRequest URLRequestWithPath:self.requestTokenPath
                                                       parameters:@{@"oauth_callback" : @"oob"}
                                                            token:nil
                                                           secret:nil
                                                      consumerKey:consumerKey
                                                   consumerSecret:consumerSecret];
    return request;
}

+ (NSString *)requestTokenPath {
    return @"/oauth/request_token";
}

@end
