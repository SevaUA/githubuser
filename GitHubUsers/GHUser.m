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

@interface GHUser ()

@property (nonatomic, strong) UIImage *avatarImage;

@end

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

- (void)avatarImageWithBlock:(ImageBlock)imageBlock {
    if (self.avatarImage) {
        imageBlock(self.avatarImage);
        return;
    }
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.avatarUrl]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    self.avatarImage = image;
                    imageBlock(image);
                });
            }
        }

    });
}

@end
