//
//  BSVimeoAuthorizationCredentials+Adapter.h
//  VimeoAPI
//
//  Created by Brian on 2/17/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSVimeoAuthorizationCredentials.h"
#import "BSVimeoDeveloperCredentials.h"

@interface BSVimeoAuthorizationCredentials (Adapter)

+ (void)authorizationCredentialsWithDeveloperCredentials:(BSVimeoDeveloperCredentials *)developerCredentials
                                    andCompletionHandler:(void (^)(BSVimeoAuthorizationCredentials *credentials))completionHandler;
@end
