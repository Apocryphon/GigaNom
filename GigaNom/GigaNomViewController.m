//
//  GigaNomViewController.m
//  GigaNom
//
//  Created by Richard Yeh on 4/7/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import "GigaNomViewController.h"
#import "FeedEntry.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "EntryDetailViewController.h"
#import "EntryTableViewCell.h"

#define GIGAURL @"https://ajax.googleapis.com/ajax/services/feed/load?q=http://feeds.feedburner.com/ommalik&v=1.0"

@implementation GigaNomViewController

@synthesize allEntries = _allEntries;
@synthesize queue = _queue;
@synthesize entryViewController = _entryViewController;

#pragma mark - Initializer

- (id)init
{
  if (self = [super initWithStyle:UITableViewStylePlain]) {
    UINavigationItem *n = [self navigationItem];
    [n setTitle:@"GigaNom News"];
    
  }
  return self;
}

//TODO: add specific styles for iPhone and iPad
- (id)initWithStyle:(UITableViewStyle)style
{
  return [self init];
}

#pragma mark - UITableViewDataSource delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.allEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";

  
  FeedEntry *entry = [self.allEntries objectAtIndex:indexPath.row];
  
  // format date for display
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//  [dateFormatter setDateStyle:NSDateFormatterShortStyle];
  NSString *entryDateString = [dateFormatter stringFromDate:entry.entryDate];
  
  // format image for display
//  UIImage *cellImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:entry.en
  
  // get new or recycled cell
  EntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryDataViewCell"];
  if (cell == nil) {
    
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"EntryTableViewCell" owner:nil options:nil];
    
    for (UIView *view in views) {
      if([view isKindOfClass:[UITableViewCell class]])
      {
        cell = (EntryTableViewCell *)view;
      }
    }
  }
  
  // Cconfigure cell with FeedEntry data
  cell.titleLabel.text = entry.entryTitle;
  cell.snippetLabel.text = entry.entrySnippet;
  cell.dateLabel.text = entryDateString;
  [cell.articleImage setImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:entry.entryPicUrl]]]];
  
  return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.entryViewController == nil) {
    self.entryViewController = [[[EntryDetailViewController alloc] initWithNibName:@"EntryDetailViewController" bundle:[NSBundle mainBundle]] autorelease];
  }
  
  FeedEntry *entry = [self.allEntries objectAtIndex:indexPath.row];
  self.entryViewController.entry = entry;
  [self.navigationController pushViewController:self.entryViewController animated:YES];
  
}

#pragma mark - RSS read operations

- (void)refresh
{
  NSURL *url = [NSURL URLWithString:GIGAURL];
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  [request setDelegate:self];
  [self.queue addOperation:request];
}

- (void)requestFinished:(ASIHTTPRequest *)request 
{
  
  [self.queue addOperationWithBlock:^{

    //  NSLog(@"This is what the responseString looks like: %@", [request responseString]);
    
    if (request.responseStatusCode == 200) {
    
      NSString *responseString = [request responseString];
      
      NSDictionary *responseData = [responseString objectFromJSONString];
      NSDictionary *jsonEntries = [[[responseData objectForKey:@"responseData"] objectForKey:@"feed"] objectForKey:@"entries"];
  //    NSLog(@"Peep this: %@", jsonEntries);

      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];


        for (NSDictionary *jEntry in jsonEntries) {          
          
          NSString *picUrl = [[[[[jEntry objectForKey:@"mediaGroups"] objectAtIndex:0] 
                                objectForKey:@"contents"] objectAtIndex:0] 
                              objectForKey:@"url"];
          
//          NSLog(@"picUrl is: %@", picUrl);


          FeedEntry *entry = [[[FeedEntry alloc] initWithEntryTitle:[jEntry objectForKey:@"title"] 
                                                          entryLink:[jEntry objectForKey:@"link"]
                                                        entryPicUrl:picUrl
                                                       entryContent:[jEntry objectForKey:@"content"]
                                                       entrySnippet:[jEntry objectForKey:@"contentSnippet"]
                                                          entryDate:[dateFormatter dateFromString:[jEntry objectForKey:@"publishedDate"]]
                                                    entryCategories:[jEntry objectForKey:@"categories"]] autorelease];    
          int insertIdx = 0;                    
          [self.allEntries insertObject:entry atIndex:insertIdx];
          [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath 
                                                                           indexPathForRow:insertIdx 
                                                                           inSection:0]]
                                withRowAnimation:UITableViewRowAnimationRight];

          
        }
      }];
      
    } else {

      NSLog(@"Error getting data: %@", [request responseString]);
    }
                                      
  }];
}


- (void)requestFailed:(ASIHTTPRequest *)request 
{
  NSError *error = [request error];
  NSLog(@"Error: %@", error);
}


#pragma mark - Memory methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
  self.entryViewController = nil;
}

- (void)dealloc
{
  [_allEntries release];
  _allEntries = nil;
  [_queue release];
  _queue = nil;
  [_entryViewController release];
  _entryViewController = nil;
  [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  UINib *nib = [UINib nibWithNibName:@"EntryTableViewCell" bundle:nil];
  
  [self.tableView registerNib:nib forCellReuseIdentifier:@"EntryTableViewCell"];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.allEntries = [NSMutableArray array];
  self.queue = [[[NSOperationQueue alloc] init] autorelease];
  [self refresh];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
}

@end
