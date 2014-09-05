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

@end
