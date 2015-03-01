//
//  GHUsersManager.h
//  GitHubUsers
//
//  Created by Sergey Pulyaev on 01.03.15.
//  Copyright (c) 2015 Sergey Pulyaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHUsersManager : NSObject

@property (nonatomic, readonly) NSArray* userList;

+ (id)sharedManager;
- (void)reloadUserList;

@end
