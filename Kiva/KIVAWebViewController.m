//
//  KIVAWebViewController.m
//  Kiva
//
//  Created by Ronald Mannak on 6/15/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVAWebViewController.h"

@interface KIVAWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KIVAWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadURL];
}

- (void)loadURL
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    [self loadURL];
}

- (IBAction)close:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:NULL];
}

@end
