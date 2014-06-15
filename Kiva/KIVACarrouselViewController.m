//
//  KIVACarrouselViewController.m
//  Kiva
//
//  Created by Ronald Mannak on 6/15/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVACarrouselViewController.h"

@interface KIVACarrouselViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation KIVACarrouselViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.label.text = self.carrouselTitle;
}

- (void)setCarrouselTitle:(NSString *)carrouselTitle
{
    _carrouselTitle = self.label.text = carrouselTitle;
}

@end
