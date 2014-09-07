//
//  WildPokemonViewController.h
//  Pokemon
//
//  Created by Daniel Stepanov on 9/7/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookAPI.h"
#import <Firebase/Firebase.h>

@interface WildPokemonViewController : UIViewController <FBAPIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonLevel;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *status;
- (IBAction)throwPokeball:(id)sender;

- (IBAction)runAway:(id)sender;

@end
