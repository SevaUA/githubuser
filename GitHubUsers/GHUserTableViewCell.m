//
//  GHUserTableViewCell.m
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import "GHUserTableViewCell.h"

NSString * const GHUserCellReuseIdentifier = @"GHUserCellReuseIdentifier";

@implementation GHUserTableViewCell

- (void)setAvatarImage:(UIImage *)avatarImage {
    _avatarImage = avatarImage;
    self.avatarImageView.image = avatarImage;
    if (self.avatarImage == nil) {
        [self.loadingIndicatorView startAnimating];
    } else {
        [self.loadingIndicatorView stopAnimating];
    }
}

- (void)awakeFromNib {
    self.loadingIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.avatarImageView.bounds];
    self.loadingIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.avatarImageView addSubview:self.loadingIndicatorView];
    UITapGestureRecognizer *urlTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(urlTapped)];
    [self.urlLabel addGestureRecognizer:urlTap];
    UITapGestureRecognizer *avatarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTapped)];
    [self.avatarImageView addGestureRecognizer:avatarTap];
}

- (void)urlTapped {
    if (self.delegate) {
        [self.delegate userUrlClicked:self];
    }
}

- (void)avatarTapped {
    if (self.delegate) {
        [self.delegate avatarClicked:self];
    }
}

- (NSString *)reuseIdentifier {
    return GHUserCellReuseIdentifier;
}

@end
