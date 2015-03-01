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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHUserCellIdentifier" forIndexPath:indexPath];
    GHUser *user = [self userForIndexPath:indexPath];
    cell.textLabel.text = user.login;
    cell.detailTextLabel.text = user.htmlUrl;
    
    return cell;
}

#pragma mark - Table view private methods

- (void)userListUpdated {
    NSLog(@"count = %lu", [[[GHUsersManager sharedManager] userList] count]);
    [self.tableView reloadData];
}

- (GHUser *)userForIndexPath:(NSIndexPath *)indexPath {
    return [[[GHUsersManager sharedManager] userList] objectAtIndex:indexPath.row];
}

@end
