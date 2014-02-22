//
//  NSObject+WebViewCreation.m
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import "NSObject+WebViewCreation.h"

@implementation NSObject (WebViewCreation)

+ (UIViewController *)authorizationWebViewControllerWithURL:(NSURL *)URL {
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    UIWebView *webView = [[UIWebView alloc] init];
    [webView loadRequest:request];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = @"Vimeo";
    [viewController.view addSubview:webView];
    webView.frame = viewController.view.frame;

    return viewController;
}

@end
