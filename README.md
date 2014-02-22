BSVimeoOAuthorization
=====================

A Vimeo OAuth Objective-C adapter. I'm still in the process to organizing things but feel free to have a look.

Usage:
1. Add your Vimeo App 'Callback URL' scheme to your iOS app URL types (https://dev.twitter.com/docs/cards/ios/url-scheme-configuration).
2. Instantiate a BSVimeoAuthorizationController and provide a delegate.
2. Request a AuthorizationURL from the BSVimeoAuthorizationController via -requestUserAuthorizationURLWithCompletionHandler.
3. Provide your BSVimeoDeveloperCredentials when the BSVimeoAuthorization requests so.
3. Present a web view with that URL loaded.
4. Override application:openURL:sourceApplication:annotation of your appDelegate and post a notification with the name "didRecieveUserAuthorizationWithURL" and pass the URL into the 'object' parameter.
5. Use the BSVimeoAccessCredentials that BSVimeoAuthorizationController provides via -vimeoAuthorizationController:didBecomeAuthorizedWithCredentials to make API calls.
