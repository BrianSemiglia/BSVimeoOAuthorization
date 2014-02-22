BSVimeoOAuthorization
=====================

A Vimeo OAuth Objective-C adapter. I'm still in the process to organizing things but feel free to have a look.

Usage:
1.First, you'll need to add your Vimeo App 'Callback URL' scheme to your iOS app URL types (https://dev.twitter.com/docs/cards/ios/url-scheme-configuration).

2.Present authorization web view.

    BSVimeoAuthorizationController *vimeoAuthorizationController = [[BSVimeoAuthorizationController alloc] init];
    [self.vimeoAuthorizationController requestUserAuthorizationURLWithCompletionHandler:^(NSURL *URL) {
      dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *viewController = [NSObject authorizationWebViewControllerWithURL:URL];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self presentViewController:navigationController animated:YES completion:nil];
      });
    }];
    

3.Provide consumer key and secret in BSVimeoAuthorizationController delegate.  

    - (BSVimeoDeveloperCredentials *)developerCredentialsForVimeoAuthorizationController:(BSVimeoAuthorizationController *)controller {
      BSVimeoDeveloperCredentials *developerCredentials = [[BSVimeoDeveloperCredentials alloc] init];
      developerCredentials.consumerKey = CONSUMER_KEY;
      developerCredentials.consumerSecret = CONSUMER_SECRET;
      return developerCredentials;
    }

4.Override appDelegate method and forward authorization web view callback URL.

    - (BOOL)application:(UIApplication *)application
                openURL:(NSURL *)url
      sourceApplication:(NSString *)sourceApplication
             annotation:(id)annotation {
    
      [[NSNotificationCenter defaultCenter] postNotificationName:@"didRecieveUserAuthorizationWithURL" object:url];
      return YES;
    }

5.Save credentials from BSVimeoAuthorizationController callback and use them to make API method calls.

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

