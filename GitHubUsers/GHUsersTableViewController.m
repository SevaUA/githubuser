//
//  GHUsersTableViewController.m
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import "GHUsersTableViewController.h"
#import "GHUsersManager.h"
#import "GHUser.h"
#import "GHUserDetailViewController.h"

@interface GHUsersTableViewController ()

@end

@implementation GHUsersTableViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated) name:GHUsersManagerUserListUpdated object:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[GHUsersManager sharedManager] userList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GHUserCellReuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    GHUser *user = [self userForIndexPath:indexPath];
    cell.loginLabel.text = user.login;
    cell.urlLabel.text = user.htmlUrl;
    cell.avatarImage = nil;
    [user avatarImageWithBlock:^(UIImage *image) {
        if ([user.login isEqual:cell.loginLabel.text]) {
            cell.avatarImage = image;
        }
    }];
    
    return cell;
}

#pragma mark - GHUserTableViewCellTapProtocol

- (void)userUrlClicked:(UITableViewCell *)onCell {
    GHUser *user = [self userForIndexPath:[self.tableView indexPathForCell:onCell]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:user.htmlUrl]];
}

- (void)avatarClicked:(UITableViewCell *)onCell {
    GHUser *user = [self userForIndexPath:[self.tableView indexPathForCell:onCell]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GHUserDetailViewController *vc = (GHUserDetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GHUserDetailViewControllerID"];
    vc.user = user;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Table view private methods

- (void)userListUpdated {
    [self.tableView reloadData];
}

- (GHUser *)userForIndexPath:(NSIndexPath *)indexPath {
    return [[[GHUsersManager sharedManager] userList] objectAtIndex:indexPath.row];
}

@end
