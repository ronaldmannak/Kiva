//
//  KIVAFilterViewController.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVAFilterViewController.h"
#import "KIVACarrouselViewController.h"
#import "KIVADataManager.h"

@interface KIVAFilterViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView   *collectionView;
@property (weak, nonatomic) KIVACarrouselViewController *carrouselViewController;
@end

@implementation KIVAFilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.carrouselViewController = self.childViewControllers.firstObject;
    self.carrouselViewController.carrouselTitle = @"Filter Results";
    self.carrouselViewController.loans = [KIVADataManager sharedManager].allLoans;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:NULL];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"RegionsID" forIndexPath:indexPath];
    NSAssert(cell, @"No cell");
    return cell;
}

//#pragma mark - UICollectionViewDelegate
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    KIVALoan *loan = self.loans[indexPath.row];
//    NSString *path = [@"http://www.kiva.org/lend/" stringByAppendingPathComponent:@(loan.loanID).stringValue];
//    KIVAWebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewControllerID"];
//    [self presentViewController:webVC animated:YES
//                     completion:NULL];
//    webVC.url = [NSURL URLWithString:path];
//}

@end
