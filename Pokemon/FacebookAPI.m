//
//  FacebookAPI.m
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "FacebookAPI.h"

@implementation FacebookAPI

+ (void)getPublicProfile:(id<FBAPIDelegate>)delegate {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
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
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }];
}

+ (void)getUserFriends:(id<FBAPIDelegate>)delegate
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
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
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

+ (void)getCurrentUserPicture:(id<FBAPIDelegate>)delegate
{
    NSString *queryString = @"me/picture";
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    __block NSString *identifier = @"me";
    
    [FBRequestConnection startWithGraphPath:queryString
                          completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"%@", result);
             
             NSString *pictureURL = [(NSDictionary *)[result data] objectForKey:@"url"];
             
             NSDictionary *dict = @{
                                    @"url": pictureURL,
                                    @"id": identifier
                                    };
             
             if ([delegate respondsToSelector:@selector(userProfilePictureReceived:)]) {
                 [delegate userProfilePictureReceived:dict];
             }
         } else {
             NSLog(@"error: %@", error);
         }
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }];
}

+ (void)getUserPictureByID:(NSString *)userID withDelegate:(id<FBAPIDelegate>)delegate
{
    NSString *queryString = [userID stringByAppendingString:@"/picture"];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    __block NSString *identifier = [userID copy];
    
    [FBRequestConnection startWithGraphPath:queryString
                          completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSLog(@"%@", result);

            NSString *pictureURL = [(NSDictionary *)[result data] objectForKey:@"url"];

            NSDictionary *dict = @{
                @"url": pictureURL,
                @"id": identifier
            };

            if ([delegate respondsToSelector:@selector(userProfilePictureReceived:)]) {
              [delegate userProfilePictureReceived:dict];
            }
        } else {
            NSLog(@"error: %@", error);
        }
                              
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

@end
