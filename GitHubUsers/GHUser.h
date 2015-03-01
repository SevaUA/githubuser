//
//  GHUser.h
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GHUser;
typedef void (^ImageBlock)(UIImage *image);

@interface GHUser : NSObject

+ (GHUser *)userWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *htmlUrl;
@property (nonatomic, strong) NSString *avatarUrl;

- (void)avatarImageWithBlock:(ImageBlock)imageBlock;

@end
