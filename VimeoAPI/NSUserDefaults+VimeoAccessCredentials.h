//
//  NSUserDefaults+VimeoAccessCredentials.h
//  VimeoAPI
//
//  Created by Brian on 2/18/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BSVimeoAccessCredentials;

@interface NSUserDefaults (VimeoAccessCredentials)

- (void)resetSavedCredentials;

- (BSVimeoAccessCredentials *)savedCredentials;

- (void)saveCredentials:(BSVimeoAccessCredentials *)credentials;

@end
