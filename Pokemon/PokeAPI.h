//
//  PokeAPI.h
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Underscore.h"

@interface PokeAPI : NSObject

// VC helper methods used for app functionality
+ (NSDictionary *)findOnePokemonByString:(NSString *)query;
+ (NSDictionary *)getWildPokemon;

// Sometimes we get resource uri's as a reference from the API,
// e.g. in a pokemon['abilities'], each has a resource URI to get
// said ability, so we have a full URI so we don't use the method below
+ (NSDictionary *)getResponseWithResourceURI:(NSString *)resourceURI;

// The basic API calls for specific objects
+ (NSDictionary *)getTypeWithID:(NSString *)id;

+ (NSDictionary *)getAbilityWithID:(NSString *)id;

+ (NSDictionary *)getPokemonWithID:(NSString *)id;

// This literally gets all the pokemon, around 500 or 700
+ (NSArray *)getPokedex;

@end
