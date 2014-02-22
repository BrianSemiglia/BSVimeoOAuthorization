//
//  VimeoUploaderViewController.h
//  CandyClock
//
//  Created by Brian on 12/9/12.
//
//

#import <UIKit/UIKit.h>
#import "BSVimeoAuthorizationControllerDelegate.h"

typedef NS_OPTIONS (NSUInteger, VimeoAccessAuthorizationState) {
    VimeoAccessControllerUnauthorized,
    VimeoAccessControllerAuthorized
};

@interface BSVimeoAuthorizationController : NSObject

/**
 
 */
@property (nonatomic, assign) VimeoAccessAuthorizationState authorizationState;

/**
 
 */
@property (nonatomic, weak) id<BSVimeoAuthorizationControllerDelegate> delegate;

// This begins the authorization process.
// Responder must display a webview with URL.
/**
 *
 */
- (void)requestUserAuthorizationURLWithCompletionHandler:(void (^)(NSURL *URL))completionHandler;

@end

// 1. secret & url
// 2. secret & request token & verifier
// 3. secret & token