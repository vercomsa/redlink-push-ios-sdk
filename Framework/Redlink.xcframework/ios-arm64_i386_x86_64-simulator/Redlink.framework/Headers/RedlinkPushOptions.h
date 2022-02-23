//
//  RedlinkPushOptions.h
//  Redlink
//
//  Created by Mateusz Tylman on 04/10/2018.
//  Copyright © 2018 Michal Banaszynski. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UserNotifications;

NS_ASSUME_NONNULL_BEGIN

@interface RedlinkPushOptions : NSObject

typedef NS_OPTIONS(NSInteger, RedlinkPushAuthorizationOptions) {
    RedlinkPushAuthorizationOptionsBadge = UNAuthorizationOptionBadge,
    RedlinkPushAuthorizationOptionsSound = UNAuthorizationOptionSound,
    RedlinkPushAuthorizationOptionsAlert = UNAuthorizationOptionAlert,
    RedlinkPushAuthorizationOptionsCarPlay = UNAuthorizationOptionCarPlay,
};

@property (assign, nonatomic) RedlinkPushAuthorizationOptions authorizationOptions;
@property (assign, nonatomic) BOOL useAutomaticConfiguration;

+ (RedlinkPushOptions *)defaultOptions;
- (id)initWithAuthorizationOptions:(RedlinkPushAuthorizationOptions)authorizationOptions useAutomaticConfiguration:(BOOL)useAutomaticConfiguration;

@end

NS_ASSUME_NONNULL_END
