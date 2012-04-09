//
//  FeedEntry.h
//  GigaNom
//
//  Created by Richard Yeh on 4/8/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedEntry : NSObject
{
  NSString *_entryTitle;
  NSString *_entryLink;
  NSString *_entryContent;
  NSString *_entrySnippet;
  NSDate *_entryDate;
  NSArray *_entryCategories;
  
}

@property (copy) NSString *entryTitle;
@property (copy) NSString *entryLink;
@property (copy) NSString *entryContent;
@property (copy) NSString *entrySnippet;
@property (copy) NSDate *entryDate;
@property (copy) NSArray *entryCategories;

- (id)initWithEntryTitle:(NSString *)entryTitle 
              entryLink:(NSString *)entryLink 
           entryContent:(NSString *)entryContent 
           entrySnippet:(NSString *)entrySnippet 
              entryDate:(NSDate *)entryDate  
        entryCategories:(NSArray *)entryCategories;

@end
