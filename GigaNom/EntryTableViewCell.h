//
//  EntryTableViewCell.h
//  GigaNom
//
//  Created by Richard Yeh on 4/9/12.
//  Copyright (c) 2012 UC Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryTableViewCell : UITableViewCell
{
  IBOutlet UIImageView *_articleImage;
  IBOutlet UILabel *_titleLabel;
  IBOutlet UITextView *_snippetLabel;
  IBOutlet UILabel *_dateLabel;

}
@property (retain, nonatomic) IBOutlet UIImageView *articleImage;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UITextView *snippetLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;

@end
