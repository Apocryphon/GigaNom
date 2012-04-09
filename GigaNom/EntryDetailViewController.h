//
//  EntryDetailViewController.h
//  GigaNom
//
//  Created by Richard Yeh on 4/9/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedEntry;

@interface EntryDetailViewController : UIViewController
{
  UIWebView *_webView;
  FeedEntry *_entry;
}

@property (retain) IBOutlet UIWebView *webView;
@property (retain) FeedEntry *entry;

@end
