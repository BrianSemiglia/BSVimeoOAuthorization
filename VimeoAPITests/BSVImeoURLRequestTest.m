//
//  BSVImeoURLRequestTest.m
//  VimeoAPI
//
//  Created by Brian on 2/18/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSVimeoURLRequest.h"

@interface BSVImeoURLRequestTest : XCTestCase

@end

@implementation BSVImeoURLRequestTest

- (void)testVerifierFromURLEncodedString {
    NSString *URLEncodedString = @"oauth_token=448bb1d1a1c586b50cca0461cd81955d&verifier=BOAT&oauth_callback_confirmed=true";
    NSString *value = [BSVimeoURLRequest valueFromURLEncodedString:URLEncodedString forKey:@"verifier"];
    XCTAssert([value isEqualToString:@"BOAT"], @"");
}

- (void)testTokenFromURLEncodedString {
    NSString *URLEncodedString = @"oauth=448bb1d1a1c586b50cca0461cd81955d&verifier=BOAT&oauth_token=true";
    NSString *value = [BSVimeoURLRequest valueFromURLEncodedString:URLEncodedString forKey:@"oauth_token"];
    XCTAssert([value isEqualToString:@"true"], @"");
}

- (void)testSecretFromURLEncodedString {
    NSString *URLEncodedString = @"oauth_token_secret=448bb1d1a1c586b50cca0461cd81955d&verifier=BOAT&oauth_callback_confirmed=true";
    NSString *value = [BSVimeoURLRequest valueFromURLEncodedString:URLEncodedString forKey:@"oauth_token_secret"];
    XCTAssert([value isEqualToString:@"448bb1d1a1c586b50cca0461cd81955d"], @"");
}

- (void)testValueFromURLEncodedString {
    NSString *URLEncodedString = @"oauth_token=448bb1d1a1c586b50cca0461cd81955d&banana=BOAT&oauth_callback_confirmed=true";
    NSString *value = [BSVimeoURLRequest valueFromURLEncodedString:URLEncodedString forKey:@"banana"];
    XCTAssert([value isEqualToString:@"BOAT"], @"");
}

@end
