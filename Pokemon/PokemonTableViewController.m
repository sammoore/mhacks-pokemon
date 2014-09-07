//
//  PokemonTableViewController.m
//  Pokemon
//
//  Created by Sam Moore on 9/7/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "PokemonTableViewController.h"

@interface PokemonTableViewController ()

@property (strong, nonatomic) Firebase *FBRef;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSDictionary *pokemonDict;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation PokemonTableViewController

- (Firebase *)FBRef {
    if (_FBRef == nil) {
        _FBRef = [[Firebase alloc] initWithUrl: @"https://mhacks-pokemon.firebaseio.com/pokemon"];
    }
    
    return _FBRef;
}

- (NSString *)userID {
    if (_userID == nil) {
        [FacebookAPI getPublicProfile:self];
    }
    
    return _userID;
}

- (void)publicProfileReceived:(NSDictionary *)publicProfile
{
    _userID = publicProfile[@"id"];
    [self reloadTable];
}

- (void)reloadTable
{
    if (self.userID != nil && self.pokemonDict != nil)
    {
        //NSLog(@"hi");
        
        NSDictionary *temp = Underscore.rejectValues([self.pokemonDict objectForKey:self.userID], Underscore.isNull);
        
        NSMutableArray *dataSource = [[NSMutableArray alloc] init];
        
        for (NSDictionary *pokemon in temp) {
            NSLog(@"%@", pokemon);
            NSString *pid = [NSString stringWithFormat:@"%@", temp[pokemon] [@"pokemon_id"]];
            [dataSource addObject:[PokeAPI getPokemonWithID:pid]];
        }
        
        NSLog(@"%@", dataSource);
        self.dataSource = (NSArray *)[dataSource copy];
        
        [self.tableView reloadData];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [FacebookAPI getPublicProfile:self];
    }
    return self;
}

- (void)updatePokemon:(NSDictionary *)dict
{
    self.pokemonDict = (NSDictionary *)dict;
    [self reloadTable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"hi!");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.FBRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self updatePokemon:snapshot.value];
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (self.dataSource == nil) return 0;
    
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    NSDictionary *p = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [p objectForKey:@"name"];
    
    NSString *spriteURI = [[p[@"sprites"] firstObject] objectForKey:@"resource_uri"];
    NSString *spriteImageURL = [@"http://pokeapi.co" stringByAppendingString: [[PokeAPI getResponseWithResourceURI:spriteURI] objectForKey:@"image"]];
    
    cell.imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: spriteImageURL]]];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
