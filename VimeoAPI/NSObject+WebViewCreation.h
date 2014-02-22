//
//  NSObject+WebViewCreation.h
//  VimeoAPI
//
//  Created by Brian on 2/15/14.
//  Copyright (c) 2014 Brian Semiglia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WebViewCreation)

+ (UIViewController *)authorizationWebViewControllerWithURL:(NSURL *)URL;

@end
