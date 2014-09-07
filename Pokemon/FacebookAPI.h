//
//  FacebookAPI.h
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@protocol FBAPIDelegate <NSObject>
@optional
- (void) publicProfileReceived:(NSDictionary *)publicProfile;
- (void) userFriendsReceived:(NSArray *)usersFriends;
- (void) userProfilePictureReceived:(NSDictionary *)userPictureDict;
- (void) getCurrentUserPicture:(id<FBAPIDelegate>)delegate;
@end

@interface FacebookAPI : NSObject

+ (void)getPublicProfile:(id<FBAPIDelegate>)delegate;
+ (void)getUserFriends:(id<FBAPIDelegate>)delegate;
+ (void)getUserPictureByID:(NSString *)id withDelegate:(id<FBAPIDelegate>)delegate;

@end
