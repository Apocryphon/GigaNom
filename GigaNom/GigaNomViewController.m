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

#define GIGAURL @"https://ajax.googleapis.com/ajax/services/feed/load?q=http://feeds.feedburner.com/ommalik&v=1.0"

@implementation GigaNomViewController

@synthesize allEntries = _allEntries;
@synthesize queue = _queue;

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.allEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                   reuseIdentifier:CellIdentifier] autorelease];  /// change later to custom cell
  }
  
  FeedEntry *entry = [self.allEntries objectAtIndex:indexPath.row];
  
  // format date for display
  NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  NSString *entryDateString = [dateFormatter stringFromDate:entry.entryDate];
  
  /// change accordingly for custom cell style
  cell.textLabel.text = entry.entryTitle;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", entryDateString, entry.entrySnippet];
  
  return cell;
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

  //  NSLog(@"This is what the responseString looks like: %@", [request responseString]);
  if (request.responseStatusCode == 200) {
  
    NSString *responseString = [request responseString];
    
    // is JSONValue in SBJson framework (parses JSON text in string)
    NSDictionary *responseData = [responseString objectFromJSONString];
    NSDictionary *jsonEntries = [[[responseData objectForKey:@"responseData"] objectForKey:@"feed"] objectForKey:@"entries"];
    NSLog(@"Peep this: %@", jsonEntries);


    
    
    FeedEntry *entry = [[[FeedEntry alloc] initWithEntryTitle:request.url.absoluteString entryLink:@"1" entryContent:@"2" entrySnippet:@"3" entryDate:[NSDate date] entryCategories:[NSArray array]] autorelease];    
    int insertIdx = 0;                    
    [self.allEntries insertObject:entry atIndex:insertIdx];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath 
                                                                   indexPathForRow:insertIdx 
                                                                   inSection:0]]
                        withRowAnimation:UITableViewRowAnimationRight];
    
  }
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
}

- (void)dealloc
{
  [_allEntries release];
  _allEntries = nil;
  [_queue release];
  _queue = nil;
  
  [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
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
