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
    
    [self requestAccessCredentialsUsingToken:requestCredentials.token
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

/**
 Returns a URL request used for retrieving a Vimeo access token.
 @param The access request credentials created after the user has allowed access to their Vimeo account.
 @discussion
 */
+ (NSURLRequest *)accessTokenURLRequestWithToken:(NSString *)token
                                          secret:(NSString *)secret
                                     consumerKey:(NSString *)consumerKey
                                  consumerSecret:(NSString *)consumerSecret
                                     andVerifier:(NSString *)verifier {
    NSDictionary *parameters = @{@"oauth_verifier" : verifier, @"oauth_callback" : @"oob"};
    NSURLRequest *request = [BSVimeoURLRequest URLRequestWithPath:self.accessTokenPath
                                                       parameters:parameters
                                                            token:token
                                                           secret:secret
                                                      consumerKey:consumerKey
                                                   consumerSecret:consumerSecret];
    return request;
}

+ (NSString *)accessTokenPath {
    return @"/oauth/access_token";
}

+ (void)requestAccessCredentialsUsingToken:(NSString *)token
                                    secret:(NSString *)secret
                               consumerKey:(NSString *)consumerKey
                            consumerSecret:(NSString *)consumerSecret
                                  verifier:(NSString *)verifier
                      andCompletionHandler:(void (^)(BSVimeoAccessCredentials *))completionHandler {
    
    void (^dataTaskCompletionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *stringReponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *token = [BSVimeoURLRequest tokenFromURLEncodedString:stringReponse];
        NSString *secret = [BSVimeoURLRequest secretFromURLEncodedString:stringReponse];
        BSVimeoAccessCredentials *accessCredentials = [[BSVimeoAccessCredentials alloc] initWithToken:token
                                                                                               secret:secret
                                                                                          consumerKey:consumerKey
                                                                                    andConsumerSecret:consumerSecret];
        completionHandler(accessCredentials);
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *accessTokenURLRequest = [self accessTokenURLRequestWithToken:token
                                                                        secret:secret
                                                                   consumerKey:consumerKey
                                                                consumerSecret:consumerSecret andVerifier:verifier];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:accessTokenURLRequest completionHandler:dataTaskCompletionHandler];
    [dataTask resume];
}

@end
