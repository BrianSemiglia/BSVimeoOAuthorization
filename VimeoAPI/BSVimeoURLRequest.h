//
//  BSVimeoURLRequest.h
//  CandyClock
//
//  Created by Brian on 2/5/13.
//
//

#import <Foundation/Foundation.h>

@interface BSVimeoURLRequest : NSObject

/**
 Returns a verifier from the specified URL encoded string.
 @param
 @discussion
 */
+ (NSString *)verifierFromURLEncodedString:(NSString *)string;

/**
 Returns a token from the specified URL encoded string.
 @param
 @discussion
 */
+ (NSString *)tokenFromURLEncodedString:(NSString *)string;

/**
 Returns a secret from the specified URL encoded string.
 @param
 @discussion
 */
+ (NSString *)secretFromURLEncodedString:(NSString *)string;

/**
 Returns the value for the specified key found within the specified URL encoded string.
 @param
 @param
 @discussion
 */
+ (NSString *)valueFromURLEncodedString:(NSString *)string
                                 forKey:(NSString *)key;

/**
 
 */
+ (NSURLRequest *)URLRequestWithPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                               token:(NSString *)token
                              secret:(NSString *)secret
                         consumerKey:(NSString *)consumerKey
                      consumerSecret:(NSString *)consumerSecret;

@end
