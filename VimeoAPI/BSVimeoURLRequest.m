//
//  BSVimeoURLRequest.m
//  CandyClock
//
//  Created by Brian on 2/5/13.
//
//

#import "BSVimeoURLRequest.h"
#import "GCOAuth.h"

@interface BSVimeoURLRequest ()
+ (NSURLRequest *)URLRequestWithPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                               token:(NSString *)token
                              secret:(NSString *)secret
                         consumerKey:(NSString *)consumerKey
                      consumerSecret:(NSString *)consumerSecret;
@end

@implementation BSVimeoURLRequest

+ (NSURLRequest *)URLRequestWithPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                               token:(NSString *)token
                              secret:(NSString *)secret
                         consumerKey:(NSString *)consumerKey
                      consumerSecret:(NSString *)consumerSecret {
    
    NSURLRequest *request = [GCOAuth URLRequestForPath:path
                                         GETParameters:parameters
                                                scheme:@"https"
                                                  host:@"vimeo.com"
                                           consumerKey:consumerKey
                                        consumerSecret:consumerSecret
                                           accessToken:token
                                           tokenSecret:secret];
    return request;
}

+ (NSString *)verifierFromURLEncodedString:(NSString *)string {
    NSString *verifier = [self valueFromURLEncodedString:string forKey:@"oauth_verifier"];
    return verifier;
}

+ (NSString *)tokenFromURLEncodedString:(NSString *)string {
    NSString *token = [self valueFromURLEncodedString:string forKey:@"oauth_token"];
    return token;
}

+ (NSString *)secretFromURLEncodedString:(NSString *)string {
    NSString *secret = [self valueFromURLEncodedString:string forKey:@"oauth_token_secret"];
    return secret;
}

+ (NSString *)valueFromURLEncodedString:(NSString *)string
                                 forKey:(NSString *)key {
    
    NSURL *URL = [NSURL URLWithString:string];
    if (URL.scheme) {
        NSString *schemeWithFormatting = [NSString stringWithFormat:@"%@://?", URL.scheme];
        NSRange range = [URL.absoluteString rangeOfString:schemeWithFormatting];
        string = [[string substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    NSArray * keyValues = [string componentsSeparatedByString:@"&"];
    if (keyValues.count < 1) {
        return nil;
    }
    NSString *targetKeyValueString = nil;
    for (NSString *keyValueString in keyValues) {
        if ([keyValueString hasPrefix:[NSString stringWithFormat:@"%@=", key]]) {
            targetKeyValueString = keyValueString;
            break;
        }
    }
    
    if (!targetKeyValueString) {
        return nil;
    }
    NSArray *keyValue = [targetKeyValueString componentsSeparatedByString:@"="];
    if (keyValue.count < 2) {
        return nil;
    }
    NSString *value = keyValue[1];
    return value;
}

+ (NSString *)requestTokenPath {
    return @"/oauth/request_token";
}

+ (NSString *)accessTokenPath {
    return @"/oauth/access_token";
}

+ (NSString *)methodPath {
    return @"/api/rest/v2";
}

@end
