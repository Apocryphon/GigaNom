//
//  GigaNomViewController.m
//  GigaNom
//
//  Created by Richard Yeh on 4/7/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import "GigaNomViewController.h"
#import "FeedEntry.h"

@implementation GigaNomViewController

@synthesize allEntries = _allEntries;

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

#pragma mark- Memory methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
  [_allEntries release];
  _allEntries = nil;
  [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.allEntries = [NSMutableArray array];  

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
