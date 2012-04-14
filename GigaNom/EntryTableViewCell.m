//
//  EntryTableViewCell.m
//  GigaNom
//
//  Created by Richard Yeh on 4/9/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import "EntryTableViewCell.h"

@implementation EntryTableViewCell
@synthesize articleImage = _articleImage;
@synthesize titleLabel = _titleLabel;
@synthesize snippetLabel = _snippetLabel;
@synthesize dateLabel = _dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
  [_articleImage release];
  [_titleLabel release];
  [_snippetLabel release];
  [_dateLabel release];
  [super dealloc];
}
@end
