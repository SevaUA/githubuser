//
//  GHUserDetailViewController.h
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHUser.h"

@interface GHUserDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) GHUser *user;

@end
