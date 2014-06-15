//
//  KIVACarrouselViewController.m
//  Kiva
//
//  Created by Ronald Mannak on 6/15/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVACarrouselViewController.h"
#import "KIVALoanCell.h"
#import "KIVALoan.h"
#import "KIVAWebViewController.h"

@interface KIVACarrouselViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation KIVACarrouselViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.label.text = self.carrouselTitle;
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (void)setCarrouselTitle:(NSString *)carrouselTitle
{
    _carrouselTitle = self.label.text = carrouselTitle;
}

- (void)setLoans:(NSArray *)loans
{
    _loans = loans;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.loans.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KIVALoanCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"KIVALoanCellID" forIndexPath:indexPath];
    NSAssert(cell, @"No cell");
    
    cell.loan = self.loans[indexPath.row];    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KIVALoan *loan = self.loans[indexPath.row];
    NSString *path = [@"http://www.kiva.org/lend/" stringByAppendingPathComponent:@(loan.loanID).stringValue];
    KIVAWebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewControllerID"];
    [self presentViewController:webVC animated:YES
                     completion:NULL];
    webVC.url = [NSURL URLWithString:path];
}

@end
