//
//  BSVimeoAuthorizationControllerDelegate.h
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSVimeoAccessCredentials;
@class BSVimeoAuthorizationController;
@class BSVimeoDeveloperCredentials;

@protocol BSVimeoAuthorizationControllerDelegate <NSObject>

- (BSVimeoDeveloperCredentials *)developerCredentialsForVimeoAuthorizationController:(BSVimeoAuthorizationController *)authorizationController;

- (BSVimeoAccessCredentials *)existingCredentialsForVimeoAuthorizationController:(BSVimeoAuthorizationController *)authorizationController;

@optional

- (void)vimeoAuthorizationController:(BSVimeoAuthorizationController *)authorizationController
  didBecomeAuthorizedWithCredentials:(BSVimeoAccessCredentials *)credentials;

- (void)vimeoAuthorizationController:(BSVimeoAuthorizationController *)authorizationController
            willInvalidateCredentials:(BSVimeoAccessCredentials *)credentials;

@end
