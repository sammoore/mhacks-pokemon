//
//  FacebookAPI.m
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "FacebookAPI.h"
#import "PokemapViewController.h"

@implementation FacebookAPI

+ (void)getPublicProfile:(id<FBAPIDelegate>)delegate {
    [FBRequestConnection startForMeWithCompletionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"%@", result);
             
             NSDictionary *public_profile = (NSDictionary *)result;
             
             //[sender updateName:public_profile[@"name"]];
             if ([delegate respondsToSelector:@selector(publicProfileReceived:)]) {
                 [delegate publicProfileReceived:public_profile];
             }
         } else {
             NSLog(@"error: %@", error);
         }
     }];
}

+ (void)getUserFriends:(id<FBAPIDelegate>)delegate
{
    [FBRequestConnection startWithGraphPath:@"me/friends" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if(!error) {
            NSLog(@"%@", result);
            
            NSArray *user_friends = (NSArray *)[result data];
            
            if ([delegate respondsToSelector:@selector(userFriendsReceived:)]) {
                [delegate userFriendsReceived:user_friends];
            }
        } else {
            NSLog(@"error: %@", error);
        }
    }];
}

@end
