//
//  KIVALoginViewController.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVALoginViewController.h"
#import <FacebookSDK.h>
#import "KIVAWSAPIClient.h"
#import "KIVADataManager.h"

// temp
#import "KIVALoan.h"

@interface KIVALoginViewController ()<FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet FBLoginView            *loginView;
@property (weak, nonatomic) IBOutlet FBProfilePictureView   *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel                *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel                *statusLabel;

@end

@implementation KIVALoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginView.readPermissions = @[
                                      @"public_profile",
                                      @"user_tagged_places",
                                      @"user_about_me",
                                      @"user_education_history",
                                      @"user_location",
                                      @"user_photos",
                                      @"user_religion_politics",
                                      ];
    self.loginView.delegate = self;
    
    [KIVALoan importLoansFromDisk];
    
    // Do any additional setup after loading the view.
}
- (IBAction)kivaLogin:(UIButton *)sender
{
//    sender.enabled = NO;
    [[KIVAWSAPIClient sharedClient] openSession:^(BOOL success) {

        [[KIVADataManager sharedManager] allLoanSuccess:^(NSArray *loans) {
            NSLog(@"loans: %@", loans);
        }];
//        [[KIVADataManager sharedManager] loansOfType:KIVALoanTypeExpiring success:^(NSArray *loans) {
//            ;
//        }];
        
    }];
}

#pragma mark - FBLoginViewDelegate

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    self.profileImageView.profileID = user.id;
    self.nameLabel.text = user.name;
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    self.statusLabel.text = @"You're logged in as";
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    self.profileImageView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged";
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
