//
//  PokedexViewController.m
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "PokedexViewController.h"
#import "PokeAPI.h"

@interface PokedexViewController ()

@end

@implementation PokedexViewController


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _searchTextField)
    {
        [textField resignFirstResponder];
        [self searchFieldReturned:textField];
    }
    return NO;
}

#pragma mark - Interface Actions

- (void)searchFieldReturned:(UITextField *)sender
// or IBAction return and id sender but we're triggering this,
// and 'return' can't trigger an IBAction, so better code completion rules
{
    NSDictionary *pokemon = [PokeAPI findOnePokemonByString:[sender text]];
    
    if (pokemon == nil)
        NSLog(@"No Pokemon found like wat");
    else
        NSLog(@"You found: %@", [pokemon objectForKey:@"name"]);
}

#pragma mark - VC overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
