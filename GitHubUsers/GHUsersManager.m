//
//  GHUsersManager.m
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import "GHUsersManager.h"
#import "GHUser.h"

NSString * const GHUsersManagerUserListUpdated = @"GHUsersManagerUserListUpdated";
NSString * const kGitHugAPIURL = @"https://api.github.com/users";

@interface GHUsersManager ()

@property (nonatomic, assign) BOOL isRequested;
@property (nonatomic, strong) NSArray *userList;

@end

@implementation GHUsersManager

+ (id)sharedManager {
    static GHUsersManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    return sharedManager;
}

- (void)reloadUserList {
    if (!self.isRequested) {
        [self startRequest];
    }
}

- (void)startRequest {
    self.isRequested = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kGitHugAPIURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            [self processResponseData:data response:response];
        }
    }];
}

- (void)processResponseData:(NSData *)data response:(NSURLResponse *)response {
    NSArray *ghUserList = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if ([NSJSONSerialization isValidJSONObject:ghUserList]) {
        [self createUserModelsWithJSON:ghUserList];
    }
}

- (void)createUserModelsWithJSON:(NSArray *)jsonArray {
    NSMutableArray *userList = [NSMutableArray new];
    for (NSDictionary *userDict in jsonArray) {
        GHUser *newUser = [GHUser userWithDictionary:userDict];
        [userList addObject:newUser];
    }
    self.userList = userList;
    self.isRequested = NO;
    [self performSelectorOnMainThread:@selector(postNotification) withObject:nil waitUntilDone:NO];
}

- (void)postNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:GHUsersManagerUserListUpdated object:nil];
}

@end
