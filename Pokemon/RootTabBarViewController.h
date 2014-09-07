//
//  RootTabBarViewController.h
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIAlertView.h>
#import <CoreLocation/CoreLocation.h>

@interface RootTabBarViewController : UITabBarController <CLLocationManagerDelegate>

- (void)startWildPokemonBattle;

@end
