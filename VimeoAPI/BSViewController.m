//
//  BSViewController.m
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "BSViewController.h"
#import "BSVimeoAuthorizationController.h"
#import "NSObject+WebViewCreation.h"
#import "BSVimeoAccessCredentials.h"
#import "NSObject+VimeoMethodCalling.h"
#import "BSVimeoDeveloperCredentials.h"
#import "NSUserDefaults+VimeoAccessCredentials.h"

#define CONSUMER_KEY @""
#define CONSUMER_SECRET @""

@interface BSViewController () <BSVimeoAuthorizationControllerDelegate>
@property (nonatomic, strong) BSVimeoAuthorizationController *vimeoAuthorizationController;
@end

@implementation BSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.vimeoAuthorizationController requestUserAuthorizationURLWithCompletionHandler:^(NSURL *URL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *viewController = [NSObject authorizationWebViewControllerWithURL:URL];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [self presentViewController:navigationController animated:YES completion:nil];
        });
    }];
}

- (BSVimeoAccessCredentials *)existingCredentialsForVimeoAuthorizationController:(BSVimeoAuthorizationController *)controller {
    return [[NSUserDefaults standardUserDefaults] savedCredentials];
}

+ (BSVimeoDeveloperCredentials *)developerCredentials {
    BSVimeoDeveloperCredentials *developerCredentials = [[BSVimeoDeveloperCredentials alloc] init];
    developerCredentials.consumerKey = CONSUMER_KEY;
    developerCredentials.consumerSecret = CONSUMER_SECRET;
    return developerCredentials;
}

- (BSVimeoDeveloperCredentials *)developerCredentialsForVimeoAuthorizationController:(BSVimeoAuthorizationController *)controller {
    return [BSViewController developerCredentials];
}

- (void)vimeoAuthorizationController:(BSVimeoAuthorizationController *)controller
  didBecomeAuthorizedWithCredentials:(BSVimeoAccessCredentials *)credentials {
    
    [[NSUserDefaults standardUserDefaults] saveCredentials:credentials];
    [self dismissViewControllerAnimated:YES completion:nil];
    [BSVimeoURLRequest getActivityCommittedByUser:@"thinkspotting"
                                 usingCredentials:[[NSUserDefaults standardUserDefaults] savedCredentials]
                             developerCredentials:[BSViewController developerCredentials]
                             andCompletionHandler:^(NSArray *activity) {
                                 
                             }];
}

- (void)vimeoAuthorizationController:(BSVimeoAuthorizationController *)controller
           willInvalidateCredentials:(BSVimeoAccessCredentials *)credentials {
    
    [[NSUserDefaults standardUserDefaults] resetSavedCredentials];
}

- (BSVimeoAuthorizationController *)vimeoAuthorizationController {
    if (_vimeoAuthorizationController) {
        return _vimeoAuthorizationController;
    }
    _vimeoAuthorizationController = [[BSVimeoAuthorizationController alloc] init];
    _vimeoAuthorizationController.delegate = self;
    return _vimeoAuthorizationController;
}

@end
