//
//  FeedEntry.m
//  GigaNom
//
//  Created by Richard Yeh on 4/8/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import "FeedEntry.h"

@implementation FeedEntry
@synthesize entryTitle = _entryTitle;
@synthesize entryLink = _entryLink;
@synthesize entryPicUrl = _entryPicUrl;
@synthesize entryContent = _entryContent;
@synthesize entrySnippet = _entrySnippet;
@synthesize entryDate = _entryDate;
@synthesize entryCategories = _entryCategories;

- (id)initWithEntryTitle:(NSString *)entryTitle 
               entryLink:(NSString *)entryLink 
             entryPicUrl:(NSString *)entryPicUrl
            entryContent:(NSString *)entryContent 
            entrySnippet:(NSString *)entrySnippet 
               entryDate:(NSDate *)entryDate 
         entryCategories:(NSArray *)entryCategories
{
  if ((self = [super init])) {
    _entryTitle = [entryTitle copy];
    _entryLink = [entryLink copy];
    _entryPicUrl = [entryPicUrl copy];
    _entryContent = [entryContent copy];
    _entrySnippet = [entrySnippet copy];
    _entryDate = [entryDate copy];
    _entryCategories = [entryCategories copy];
  }
  return self;
}

- (void)dealloc
{
  [_entryTitle release];
  _entryTitle = nil;
  [_entryLink release];
  _entryLink = nil;
  [_entryPicUrl release];
  _entryPicUrl = nil;
  [_entryContent release];
  _entryContent = nil;
  [_entrySnippet release];
  _entrySnippet = nil;
  [_entryDate release];
  _entryDate = nil;
  [_entryCategories release];
  _entryCategories = nil;
  
  [super dealloc];
}

@end
