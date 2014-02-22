BSVimeoOAuthorization
=====================

A Vimeo OAuth Objective-C adapter. I'm still in the process of organizing things but feel free to have a look. Here are some directions to get you started.

1.Add your Vimeo App 'Callback URL' scheme to your iOS app URL types (https://dev.twitter.com/docs/cards/ios/url-scheme-configuration).

2.Present authorization web view.

    // BSVimeoAuthorizationController instance must be kept alive until access credentials are returned.
    self.vimeoAuthorizationController = [[BSVimeoAuthorizationController alloc] init];
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



Copyright (c) [2014] [Brian Semiglia]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
