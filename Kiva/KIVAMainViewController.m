//
//  KIVAMainViewController.m
//  Kiva
//
//  Created by Ronald Mannak on 6/15/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVAMainViewController.h"
#import "KIVACarrouselViewController.h"
#import "KIVADataManager.h"

@interface KIVAMainViewController ()

@property (nonatomic, weak) KIVACarrouselViewController *expiringCarrousel;
@property (nonatomic, weak) KIVACarrouselViewController *geographyCarrousel;

@end

@implementation KIVAMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.expiringCarrousel = self.childViewControllers.firstObject;
    self.geographyCarrousel = self.childViewControllers.lastObject;
    NSAssert(self.expiringCarrousel, @"no expiring carrousel");
    
    self.expiringCarrousel.carrouselTitle = @"Expiring";
    self.expiringCarrousel.loans = [KIVADataManager sharedManager].expiringLoans;
    self.geographyCarrousel.carrouselTitle = @"Geography";
    self.geographyCarrousel.loans = [KIVADataManager sharedManager].geographyLoans;
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
