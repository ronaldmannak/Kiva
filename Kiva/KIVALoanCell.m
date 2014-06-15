//
//  KIVALoanCell.m
//  Kiva
//
//  Created by Ronald Mannak on 6/15/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVALoanCell.h"
#import "KIVALoan.h"
#import <UIImageView+AFNetworking.h>

@interface KIVALoanCell ()
@property (weak, nonatomic) IBOutlet UIImageView    *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel        *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *countryLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *countryFlagImageView;
@property (weak, nonatomic) IBOutlet UILabel        *amountNeededLabel;
@property (weak, nonatomic) IBOutlet UILabel        *percentageCompleteLabel;
@property (weak, nonatomic) IBOutlet UILabel        *sectorLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *sectorIconImageView;
@end

@implementation KIVALoanCell

- (void)setLoan:(KIVALoan *)loan
{
    _loan = loan;

    [self.profileImageView setImageWithURL:loan.largeImageURL
                          placeholderImage:[[UIImage alloc] init]];
    [self.countryFlagImageView setImageWithURL:loan.flagURL
                              placeholderImage:[[UIImage alloc] init]];

    self.nameLabel.text =               loan.name;
    self.countryLabel.text =            loan.country;
    self.amountNeededLabel.text =       [NSString stringWithFormat:@"$%f", loan.loanAmount];
    self.percentageCompleteLabel.text = [NSString stringWithFormat:@"%f%%", loan.fundedPercentage];
    self.sectorLabel.text =             loan.sector;
}

@end
