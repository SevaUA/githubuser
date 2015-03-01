//
//  GHUserDetailViewController.m
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import "GHUserDetailViewController.h"

@interface GHUserDetailViewController ()

@end

@implementation GHUserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    GHUserDetailViewController *weakSelf = self;
    [self.user avatarImageWithBlock:^(UIImage *image) {
        weakSelf.imageView.image = image;
    }];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
