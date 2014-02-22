//
//  NSUserDefaults+VimeoAccessCredentials.m
//  VimeoAPI
//
//  Created by Brian on 2/18/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "NSUserDefaults+VimeoAccessCredentials.h"
#import "BSVimeoAccessCredentials.h"

@implementation NSUserDefaults (VimeoAccessCredentials)

- (void)resetSavedCredentials {
    [self setObject:nil forKey:@"accessCredentials"];
    [self synchronize];
}

- (BSVimeoAccessCredentials *)savedCredentials {
    NSData *data = [self objectForKey:@"accessCredentials"];
    BSVimeoAccessCredentials *accessCredentials = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return accessCredentials;
}

- (void)saveCredentials:(BSVimeoAccessCredentials *)credentials {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:credentials];
    [self setObject:data forKey:@"accessCredentials"];
    [self synchronize];
}

@end
