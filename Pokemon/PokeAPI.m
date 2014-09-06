//
//  PokeAPI.m
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "PokeAPI.h"

@implementation PokeAPI

+ (instancetype) sharedInstance
{
    static dispatch_once_t pred;
    static PokeAPI *manager = nil;
	
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
    });
    return manager;
}



@end
