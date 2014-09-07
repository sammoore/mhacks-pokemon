//
//  WildPokemonViewController.m
//  Pokemon
//
//  Created by Daniel Stepanov on 9/7/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "WildPokemonViewController.h"
#import "PokeAPI.h"
#import "FacebookAPI.h"
#import "PokeAPI.h"
#import "Underscore/Underscore.h"

@interface WildPokemonViewController ()

@property int PokemonID;
@property NSString* PokemonLev;

@end

@implementation WildPokemonViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    NSDictionary *pokemon = [PokeAPI getWildPokemon];
    self.PokemonID = [pokemon[@"national_id"] intValue];
    
    //Pokemon Image
    NSString *spriteURI = [[pokemon[@"sprites"] firstObject] objectForKey:@"resource_uri"];
    NSString *spriteImageURL = [@"http://pokeapi.co" stringByAppendingString: [[PokeAPI getResponseWithResourceURI:spriteURI] objectForKey:@"image"]];
    
    _pokemonName.text = pokemon[@"name"];
    _pokemonLevel.text = self.PokemonLev = [NSString stringWithFormat:@"%d", arc4random_uniform(7) + 3];
    _pokemonImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:spriteImageURL]]];
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


- (void)searchFieldReturned:(UITextField *)sender
// or IBAction return and id sender but we're triggering this,
// and 'return' can't trigger an IBAction, so better code completion rules
{
    
    
    /*
    NSDictionary *pokemonRef = [PokeAPI findOnePokemonByString:[sender text]];
    
    if (pokemonRef == nil) return;
    
    NSDictionary *pokemon = [PokeAPI getResponseWithResourceURI:pokemonRef[@"resource_uri"]];
    //Pokemon Name
    NSString *pokedexURI = [[pokemon[@"descriptions"] firstObject] objectForKey:@"resource_uri"];
    NSDictionary *desc = [[PokeAPI getResponseWithResourceURI:pokedexURI] objectForKey:@"description"];
    //Pokemon Level
    //NSString *pokedexURI = [[pokemon[@"descriptions"] firstObject] objectForKey:@"resource_uri"];
    //NSDictionary *desc = [[PokeAPI getResponseWithResourceURI:pokedexURI] objectForKey:@"description"];
    //Pokemon Image
    NSString *spriteURI = [[pokemon[@"sprites"] firstObject] objectForKey:@"resource_uri"];
    NSString *spriteImageURL = [@"http://pokeapi.co" stringByAppendingString: [[PokeAPI getResponseWithResourceURI:spriteURI] objectForKey:@"image"]];
    //Set the above to their outlets
    _pokemonName.text = [NSString stringWithFormat:@"%@", desc];
    //_pokemonLevel.text = [NSString stringWithFormat:@"%@", num];
    _pokemonImage.image =[UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: spriteImageURL]]];
    */
}

- (void)publicProfileReceived:(NSDictionary *)publicProfile
{
    Firebase* ref = [[Firebase alloc] initWithUrl:[@"https://mhacks-pokemon.firebaseio.com/pokemon/" stringByAppendingString:publicProfile[@"id"]]];
    
    Firebase* pokemonRef = [ref childByAutoId];
    
    [pokemonRef setValue:@{
                          @"pokemon_id": [NSString stringWithFormat:@"%d", (int)self.PokemonID],
                          @"level": self.PokemonLev
                          }];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)throwPokeball:(id)sender {
    if (arc4random_uniform(100) < 70) {
        // caught
        _status.text = @"Success!";
        [FacebookAPI getPublicProfile:self];
    } else {
        // ran away
        _status.text = @"He escaped!";
        
        [self performSelector:@selector(runAway:) withObject:self afterDelay:5.0];
    }
}

- (IBAction)runAway:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
