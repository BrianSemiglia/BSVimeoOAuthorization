//
//  BSVimeoCredentials.m
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoAccessCredentials.h"
#import "BSVimeoURLRequest.h"

@interface BSVimeoAccessCredentials ()

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *consumerKey;
@property (nonatomic, copy) NSString *consumerSecret;

@end

@implementation BSVimeoAccessCredentials

- (instancetype)initWithToken:(NSString *)token
                       secret:(NSString *)secret
                  consumerKey:(NSString *)consumerKey
            andConsumerSecret:(NSString *)consumerSecret {
    self = [super init];
    if (self) {
        _token = token;
        _secret = secret;
        _consumerKey = consumerKey;
        _consumerSecret = consumerSecret;
    }
    return self;
}

- (id)initWithToken:(NSString *)token
          andSecret:(NSString *)secret {
    
    self = [super init];
    if (self) {
        _token = token;
        _secret = secret;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.secret forKey:@"secret"];
    [encoder encodeObject:self.consumerKey forKey:@"consumerKey"];
    [encoder encodeObject:self.consumerSecret forKey:@"consumerSecret"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.token = [decoder decodeObjectForKey:@"token"];
        self.secret = [decoder decodeObjectForKey:@"secret"];
        self.consumerKey = [decoder decodeObjectForKey:@"consumerKey"];
        self.consumerSecret = [decoder decodeObjectForKey:@"consumerSecret"];
    }
    return self;
}

- (BOOL)areValid {
    if (self.token && self.secret) {
        return YES;
    }
    return NO;
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

+ (void)getAccessCredentialsWithToken:(NSString *)token
                               secret:(NSString *)secret
                          consumerKey:(NSString *)consumerKey
                       consumerSecret:(NSString *)consumerSecret
                             verifier:(NSString *)verifier
                 andCompletionHandler:(void (^)(BSVimeoAccessCredentials *))completionHandler {
    
    void (^dataTaskCompletionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *stringReponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        BSVimeoAccessCredentials *accessCredentials = [[BSVimeoAccessCredentials alloc] init];
        accessCredentials.token = [BSVimeoURLRequest tokenFromURLEncodedString:stringReponse];
        accessCredentials.secret = [BSVimeoURLRequest secretFromURLEncodedString:stringReponse];
        accessCredentials.consumerKey = consumerKey;
        accessCredentials.consumerSecret = consumerSecret;
        
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
