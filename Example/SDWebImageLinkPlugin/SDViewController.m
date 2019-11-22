//
//  SDViewController.m
//  SDWebImageLinkPlugin
//
//  Created by lizhuoli1126@126.com on 11/21/2019.
//  Copyright (c) 2019 lizhuoli1126@126.com. All rights reserved.
//

#import "SDViewController.h"
#import <LinkPresentation/LinkPresentation.h>
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageLinkPlugin/SDWebImageLinkPlugin.h>

@interface SDViewController ()

@property (nonatomic, strong) LPLinkView *linkView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://www.apple.com/"];
//    self.linkView = [[LPLinkView alloc] initWithURL:url];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:self.linkView];
    [self.view addSubview:self.imageView];
    [SDImageLinkLoader.sharedLoader requestImageWithURL:url options:0 context:@{SDWebImageContextLinkRequestImageData: @(NO)} progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        self.imageView.image = image;
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    self.linkView.frame = CGRectMake(0, 0, 200, 200);
    self.imageView.frame = CGRectMake(0, 200, 400, 400);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
