//
//  VimeoUploaderViewController.m
//  CandyClock
//
//  Created by Brian on 12/9/12.
//
//

#import "BSVimeoAuthorizationController.h"
#import "BSVimeoURLRequest.h"
#import "BSVimeoAuthorizationCredentials+Adapter.h"
#import "BSVimeoAccessCredentials+Adapter.h"

@interface BSVimeoAuthorizationController ()
/**
 
 */
@property (nonatomic, strong) BSVimeoAuthorizationCredentials *authorizationCredentials;

/**
 
 */
@property (nonatomic, strong) BSVimeoAccessCredentials *accessCredentials;

@end

@implementation BSVimeoAuthorizationController

@synthesize authorizationState = _authorizationState;

- (id)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didRecieveUserAuthorizationWithURL:)
                                                     name:@"didRecieveUserAuthorizationWithURL"
                                                   object:nil];
    }
    return self;
}

- (void)requestUserAuthorizationURLWithCompletionHandler:(void (^)(NSURL *URL))completionHandler {
    BSVimeoDeveloperCredentials *developerCredentials = [self.delegate developerCredentialsForVimeoAuthorizationController:self];
    [BSVimeoAuthorizationCredentials authorizationCredentialsWithDeveloperCredentials:developerCredentials
                                                                 andCompletionHandler:^(BSVimeoAuthorizationCredentials *credentials) {
        self.authorizationCredentials = credentials;
        completionHandler(self.authorizationCredentials.URL);
    }];
}

- (void)didRecieveUserAuthorizationWithURL:(NSNotification *)notification {
    if (![notification.object isKindOfClass:[NSURL class]]) {
        return;
    }

    BSVimeoRequestCredentials *requestCredentials = [self accessRequestCredentialsWithTokenFromURL:(NSURL *)notification.object];
    [BSVimeoAccessCredentials getAccessTokenWithRequestCredentials:requestCredentials
                                              andCompletionHandler:^(BSVimeoAccessCredentials *credentials) {
         if (credentials.areValid) {
             self.authorizationState = VimeoAccessControllerAuthorized;
             self.accessCredentials = credentials;
             if ([self.delegate respondsToSelector:@selector(vimeoAuthorizationController:didBecomeAuthorizedWithCredentials:)]) {
                 [self.delegate vimeoAuthorizationController:self didBecomeAuthorizedWithCredentials:credentials];
             }
         }
    }];
}

- (VimeoAccessAuthorizationState)authorizationState {
    if (self.accessCredentials) {
        return _authorizationState = VimeoAccessControllerAuthorized;
    }
    return _authorizationState = VimeoAccessControllerUnauthorized;
}

- (void)setAuthorizationState:(VimeoAccessAuthorizationState)authorizationState {
    if (_authorizationState == authorizationState) {
        return;
    }
    _authorizationState = authorizationState;
    if (authorizationState == VimeoAccessControllerUnauthorized) {
        if ([self.delegate respondsToSelector:@selector(vimeoAuthorizationController:willInvalidateCredentials:)]) {
            [self.delegate vimeoAuthorizationController:self willInvalidateCredentials:self.accessCredentials];
        }
        self.accessCredentials = nil;
    }
}

- (BSVimeoRequestCredentials *)accessRequestCredentialsWithTokenFromURL:(NSURL *)URL {
    NSString *token = [BSVimeoURLRequest tokenFromURLEncodedString:URL.absoluteString];
    NSString *verifier = [BSVimeoURLRequest verifierFromURLEncodedString:URL.absoluteString];
    BSVimeoDeveloperCredentials *developerCredentials = [self.delegate developerCredentialsForVimeoAuthorizationController:self];
    BSVimeoRequestCredentials *accessRequestCredentials = [[BSVimeoRequestCredentials alloc] init];
    accessRequestCredentials.token = token;
    accessRequestCredentials.secret = self.authorizationCredentials.secret;
    accessRequestCredentials.verifier = verifier;
    accessRequestCredentials.consumerKey = developerCredentials.consumerKey;
    accessRequestCredentials.consumerSecret = developerCredentials.consumerSecret;
    return accessRequestCredentials;
}

@end
