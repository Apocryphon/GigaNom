//
//  EntryDetailViewController.m
//  GigaNom
//
//  Created by Richard Yeh on 4/9/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import "EntryDetailViewController.h"
#import "FeedEntry.h"

@implementation EntryDetailViewController

@synthesize webView = _webView;
@synthesize entry = _entry;

- (void)viewWillAppear:(BOOL)animated
{
  NSURL *url = [NSURL URLWithString:self.entry.entryLink];
  [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
}

- (void)didReceiveMemoryWarning 
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
  [_entry release];
  _entry = nil;
  [_webView release];
  _webView = nil;
  [super dealloc];
}

@end
