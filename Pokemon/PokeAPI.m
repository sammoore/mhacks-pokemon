//
//  PokeAPI.m
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "PokeAPI.h"
#import "JSONKit.h"

// SM: TODO: refactor obvi

// used to take a resource URI returned by other methods and make a new request
// + getResponseFromResourceURI
const NSString *kPokeApiURL = @"http://pokeapi.co";

// used for all other methods
const NSString *kPokeApiRef = @"http://pokeapi.co/api/v1/";

@implementation PokeAPI

/* // might not be needed
+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static PokeAPI *manager = nil;
	
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
 */

#pragma mark - API methods

+ (NSDictionary *)findOnePokemonByString:(NSString *)query
{
    NSArray *allPokemon = [[self getPokedex] objectForKey:@"pokemon"];
    
    Underscore.find(allPokemon, ^BOOL (NSDictionary *dict) {
        // TODO: also need to _at least_ check if dict[@"name"] begins with the query
        NSLog(@"%@", dict[@"name"]);
        if ([[dict[@"name"] lowercaseString] isEqualToString:[query lowercaseString]]) {
            return true;
        } else return false;
    });
    
    return nil;
}

+ (NSDictionary *)getWildPokemon
{
    NSArray *allPokemon = [[self getPokedex] objectForKey:@"pokemon"];
    NSDictionary *pokemon = nil;
    
    while (pokemon == nil) {
        NSUInteger index = arc4random_uniform([allPokemon count]);
        NSString *resource_uri = [[allPokemon objectAtIndex:index] objectForKey:@"resource_uri"];
        NSDictionary *p = [self getResponseWithResourceURI:resource_uri];
        
        if ([p[@"hp"] intValue] < 50) {
            pokemon = [p copy];
        }
    }
    
    return pokemon;
}

+ (NSDictionary *)getTypeWithID:(NSUInteger)id
{
    return [self dictionaryFromURL:[self requestStringFromType:@"type" withID:id]];
}

+ (NSDictionary *)getAbilityWithID:(NSUInteger)id
{
    return [self dictionaryFromURL:[self requestStringFromType:@"ability" withID:id]];
}

+ (NSDictionary *)getPokemonWithID:(NSUInteger)id
{
    return [self dictionaryFromURL:[self requestStringFromType:@"pokemon" withID:id]];
}

+ (NSDictionary *)getPokedex
{
    return [self dictionaryFromURL:[self requestStringFromType:@"pokedex" withID:1]];
}

+ (NSDictionary *)getResponseWithResourceURI:(NSString *)resourceURI
{
    return [self dictionaryFromURL:[kPokeApiURL stringByAppendingString:resourceURI]];
}

#pragma mark - Helper methods for API

+ (NSString *)requestStringFromType:(NSString *)objectType
                             withID:(NSUInteger)id
{
    NSString *apiRefWithType = [[kPokeApiRef stringByAppendingString:objectType] stringByAppendingString:@"/"];
    return [apiRefWithType stringByAppendingString:[NSString stringWithFormat:@"%li", id]];
}

+ (NSDictionary *)dictionaryFromURL:(NSString *)URL
{
    NSError *error = nil;
    NSData *response = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pokedex" ofType:@"json"]];
    
    NSArray *dictionary = [[JSONDecoder decoder] objectWithData:response];
    
    NSLog(@"%@", dictionary);
    
    if (error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    return dictionary;
}

@end
