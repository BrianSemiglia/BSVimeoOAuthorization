//
//  NSObject+VimeoMethodCalling.h
//  VimeoAPI
//
//  Created by Brian on 2/17/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoURLRequest.h"

@class BSVimeoDeveloperCredentials;
@class BSVimeoAccessCredentials;

@interface BSVimeoURLRequest (VimeoMethodCalling)

+ (void)getActivityCommittedByUser:(NSString *)user
                  usingCredentials:(BSVimeoAccessCredentials *)accessCredentials
              developerCredentials:(BSVimeoDeveloperCredentials *)developerCredentials
              andCompletionHandler:(void (^)(NSArray *))completionHandler;

@end
