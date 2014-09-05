//
//  BSVimeoAccessCredentials+Adapter.h
//  VimeoAPI
//
//  Created by Brian on 2/18/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoAccessCredentials.h"
#import "BSVimeoRequestCredentials.h"

@interface BSVimeoAccessCredentials (Adapter)

+ (void)getAccessTokenWithRequestCredentials:(BSVimeoRequestCredentials *)requestCredentials
                        andCompletionHandler:(void (^)(BSVimeoAccessCredentials *))completionHandler;
/**
 Returns a URL request used for making method call's to the Vimeo API.
 @param
 @param
 @param
 @discussion
 */
+ (NSURLRequest *)methodURLRequestWithAccessCredentials:(BSVimeoAccessCredentials *)accessCredentials
                                          andParameters:(NSDictionary *)parameters;

+ (BSVimeoAccessCredentials *)credentialsFromURLEncodedString:(NSString *)string
                                      andDeveloperCredentials:(BSVimeoDeveloperCredentials *)developerCredentials;

@end
