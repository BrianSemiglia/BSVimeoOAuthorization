BSVimeoOAuthorization
=====================

A Vimeo OAuth Objective-C adapter. I'm still in the process to organizing things but feel free to have a look.

Usage:
  1. Add your Vimeo App 'Callback URL' scheme to your iOS app URL types (https://dev.twitter.com/docs/cards/ios/url-scheme-configuration).
  2. Instantiate a BSVimeoAuthorizationController and provide a delegate.
  3. Request a AuthorizationURL from the BSVimeoAuthorizationController via -requestUserAuthorizationURLWithCompletionHandler.
  4. Provide your BSVimeoDeveloperCredentials when the BSVimeoAuthorization requests so.
  5. Present a web view with that URL loaded.
  6. Override application:openURL:sourceApplication:annotation of your appDelegate and post a notification with the name "didRecieveUserAuthorizationWithURL" and pass the URL into the 'object' parameter.
  7. Use the BSVimeoAccessCredentials that BSVimeoAuthorizationController provides via -vimeoAuthorizationController:didBecomeAuthorizedWithCredentials to make API calls.
  
Example:

Present authorization web view.

    BSVimeoAuthorizationController *vimeoAuthorizationController = [[BSVimeoAuthorizationController alloc] init];
    [self.vimeoAuthorizationController requestUserAuthorizationURLWithCompletionHandler:^(NSURL *URL) {
      dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *viewController = [NSObject authorizationWebViewControllerWithURL:URL];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self presentViewController:navigationController animated:YES completion:nil];
      });
    }];
    

Provide consumer key and secret.  

    - (BSVimeoDeveloperCredentials *)developerCredentialsForVimeoAuthorizationController:(BSVimeoAuthorizationController *)controller {
      BSVimeoDeveloperCredentials *developerCredentials = [[BSVimeoDeveloperCredentials alloc] init];
      developerCredentials.consumerKey = CONSUMER_KEY;
      developerCredentials.consumerSecret = CONSUMER_SECRET;
      return developerCredentials;
    }

Forward authorization web view callback URL.

    - (BOOL)application:(UIApplication *)application
                openURL:(NSURL *)url
      sourceApplication:(NSString *)sourceApplication
             annotation:(id)annotation {
    
      [[NSNotificationCenter defaultCenter] postNotificationName:@"didRecieveUserAuthorizationWithURL" object:url];
      return YES;
    }

Save credentials and use to make API method calls.

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

