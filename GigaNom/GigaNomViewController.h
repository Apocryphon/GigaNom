//
//  GigaNomViewController.h
//  GigaNom
//
//  Created by Richard Yeh on 4/7/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GigaNomViewController : UITableViewController
{
  NSMutableArray *_allEntries;
  NSOperationQueue *_queue;
}

@property (retain) NSMutableArray *allEntries;
@property (retain) NSOperationQueue *queue;
@end
