//
//  PokedexViewController.h
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokedexViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *spriteImageView;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end
