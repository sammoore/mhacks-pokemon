//
//  RootTabBarViewController.m
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "AppDelegate.h"

@interface RootTabBarViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *locations;

@end

@implementation RootTabBarViewController

- (void)startWildPokemonBattle {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
                            instantiateViewControllerWithIdentifier:@"wildPokemon"];
    
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - VC overrides

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locations = [[NSMutableArray alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"wtf");
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"got a location update");
    AppDelegate *ad = [[UIApplication sharedApplication] delegate];
    
    if (UIApplication.sharedApplication.applicationState != UIApplicationStateActive
        && ad.suchNotif != YES)
    {
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        if (notif) {
            notif.alertBody = @"A wild pokemon has appeared!";
            notif.applicationIconBadgeNumber = 1;
            [[UIApplication sharedApplication] presentLocalNotificationNow:notif];
            ad.suchNotif = YES;
        } else {
            NSLog(@"The notification failed");
        }
    }
    else
    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GOLLY GEE" message:@"A wild pokemon has appeared!" delegate:nil cancelButtonTitle:@"Fuck that shit" otherButtonTitles:@"I'mma kill him", nil];
//        [alert show];
    }
}

@end
