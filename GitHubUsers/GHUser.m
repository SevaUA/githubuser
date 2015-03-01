//
//  GHUser.m
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import "GHUser.h"

NSString* const kGHUserKeyLogin = @"login";
NSString* const kGHUserKeyAvatarUrl = @"avatar_url";
NSString* const kGHUserKeyHtmlUrl = @"html_url";

@implementation GHUser

+ (GHUser *)userWithDictionary:(NSDictionary *)dictionary {
    GHUser *user = [GHUser new];
    user.login = [dictionary objectForKey:kGHUserKeyLogin];
    user.avatarUrl = [dictionary objectForKey:kGHUserKeyAvatarUrl];
    user.htmlUrl = [dictionary objectForKey:kGHUserKeyHtmlUrl];
    return user;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"GHUser: %@", self.login];
}

@end
