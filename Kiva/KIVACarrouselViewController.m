//
//  KIVACarrouselViewController.m
//  Kiva
//
//  Created by Ronald Mannak on 6/15/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVACarrouselViewController.h"
#import "KIVALoanCell.h"

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

#pragma mark - UICollectionViewDelegate

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

@end
