//
//  NSObject+VimeoMethodCalling.m
//  VimeoAPI
//
//  Created by Brian on 2/17/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "NSObject+VimeoMethodCalling.h"
#import "BSVimeoAccessCredentials+Adapter.h"

@implementation BSVimeoURLRequest (VimeoMethodCalling)

+ (void)getActivityCommittedByUser:(NSString *)user
                  usingCredentials:(BSVimeoAccessCredentials *)accessCredentials
              developerCredentials:(BSVimeoDeveloperCredentials *)developerCredentials
              andCompletionHandler:(void (^)(NSArray *))completionHandler {
    
    void (^dataTaskCompletionHandler)(NSData *, NSURLResponse *, NSError *) = ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dictionary);
    };
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSDictionary *parameters = [self activityCommittedParametersForUser:user];
    NSURLRequest *request = [BSVimeoAccessCredentials methodURLRequestWithAccessCredentials:accessCredentials andParameters:parameters];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:dataTaskCompletionHandler];
    [dataTask resume];
}

+ (NSDictionary *)activityExperiencedParametersForUser:(NSString *)user {
    // GET /api/rest/v2?format=json&method=vimeo.activity.happenedToUser&user_id=thinkspotting HTTP/1.1
    NSDictionary *parameters = @{@"format": @"json",
                                 @"method" : @"vimeo.activity.happenedToUser",
                                 @"user_id" : user};
    return parameters;
}

+ (NSDictionary *)activityCommittedParametersForUser:(NSString *)user {
    // GET /api/rest/v2?format=json&method=vimeo.activity.userDid&user_id=thinkspotting HTTP/1.1
    NSDictionary *parameters = @{@"format": @"json",
                                 @"method" : @"vimeo.activity.userDid",
                                 @"user_id" : user};
    return parameters;
}

@end
