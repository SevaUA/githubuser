//
//  GHUserTableViewCell.h
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GHUserTableViewCellTapProtocol

- (void)userUrlClicked:(UITableViewCell *)onCell;
- (void)avatarClicked:(UITableViewCell *)onCell;

@end

extern NSString * const GHUserCellReuseIdentifier;

@interface GHUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@property (weak, nonatomic) id<GHUserTableViewCellTapProtocol>delegate;

@property (strong, nonatomic) UIActivityIndicatorView *loadingIndicatorView;

@property (strong, nonatomic) UIImage *avatarImage;

@end
