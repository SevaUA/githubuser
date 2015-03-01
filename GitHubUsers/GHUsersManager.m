//
//  GHUsersManager.m
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import "GHUsersManager.h"

NSString* const kGitHugAPIURL = @"https://api.github.com/users";

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
    // TODO: add isReloadStarted
    // TDOD: move it to startLoad method
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
        NSLog(@"valid json");
    }
}

@end
