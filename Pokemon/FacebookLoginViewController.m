//
//  FacebookLoginViewController.m
//  Pokemon
//
//  Created by Daniel Stepanov on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "FacebookLoginViewController.h"
#import <Firebase/Firebase.h>
#import <FacebookSDK/FacebookSDK.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>

// The Firebase you want to use for this app
// You must setup Simple Login for the various authentication providers in Forge
static NSString * const kFirebaseURL = @"https://mhacks-pokemon.firebaseio.com";

// The app ID you setup in the facebook developer console
static NSString * const kFacebookAppID = @"292571467605819";


@interface FacebookLoginViewController ()

// A dialog that is displayed while logging in
@property (nonatomic, strong) UIAlertView *loginProgressAlert;

// The simpleLogin object that is used to authenticate against Firebase
@property (nonatomic, strong) FirebaseSimpleLogin *simpleLogin;

// The user currently authenticed with Firebase
@property (nonatomic, strong) FAUser *currentUser;

@end

@implementation FacebookLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    // Hides the bottom tab bar
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  Firebase* ref = [[Firebase alloc] initWithUrl:@"https://SampleChat.firebaseIO-demo.com"];
   // FirebaseSimpleLogin* authClient = [[FirebaseSimpleLogin alloc] initWithRef:ref];
    self.tabBarController.tabBar.hidden = YES;
    Firebase *firebase = [[Firebase alloc] initWithUrl:kFirebaseURL];
    self.simpleLogin = [[FirebaseSimpleLogin alloc] initWithRef:firebase];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FacebookLoginButtonPressed:(id)sender{
   
    //[self showProgressAlert];
    // login using Facebook
    [self.simpleLogin loginToFacebookAppWithId:kFacebookAppID
                                   permissions:@[@"public_profile", @"user_friends", @"email"] //HERE IS WHERE YOU'RE
                                      audience:ACFacebookAudienceOnlyMe
                           withCompletionBlock:[self loginBlockForProviderName:@"Facebook"]];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

/*- (void)showProgressAlert
{
    // show an alert notifying the user about logging in
    self.loginProgressAlert = [[UIAlertView alloc] initWithTitle:nil
                                                         message:@"Logging in..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [self.loginProgressAlert show];
}
 */

- (void(^)(NSError *, FAUser *))loginBlockForProviderName:(NSString *)providerName
{
    // this callback block can be used for every login method
    return ^(NSError *error, FAUser *user) {
        // make sure we are on the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            // hide the login progress dialog
            [self.loginProgressAlert dismissWithClickedButtonIndex:0 animated:YES];
            self.loginProgressAlert = nil;
            if (error != nil) {
                // there was an error authenticating with Firebase
                NSLog(@"Error logging in to Firebase: %@", error);
                // display an alert showing the error message
                NSString *message = [NSString stringWithFormat:@"There was an error logging into Firebase using %@: %@",
                                     providerName,
                                     [error localizedDescription]];
                [self showErrorAlertWithMessage:message];
            }
        });
    };
}

- (void)showErrorAlertWithMessage:(NSString *)message
{
    // display an alert with the error message
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)logoutButtonPressed
{
    // logout of Firebase and set the current user to nil
    [self.simpleLogin logout];

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
