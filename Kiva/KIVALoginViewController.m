//
//  KIVALoginViewController.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVALoginViewController.h"
#import <FacebookSDK.h>

// temp
#import "KIVALoan.h"

@interface KIVALoginViewController ()

@end

@implementation KIVALoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [KIVALoan importLoansFromDisk];
    
    // Do any additional setup after loading the view.
}

@end
