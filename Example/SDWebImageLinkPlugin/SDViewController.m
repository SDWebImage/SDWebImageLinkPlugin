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
    [SDImageLoadersManager.sharedManager addLoader:SDImageLinkLoader.sharedLoader];
    SDWebImageManager.defaultImageLoader = SDImageLoadersManager.sharedManager;
    
    NSURL *url1 = [NSURL URLWithString:@"https://www.apple.com/iphone/"];
    NSURL *url2 = [NSURL URLWithString:@"https://webkit.org/"];
    self.linkView = [[LPLinkView alloc] initWithURL:url1];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.linkView];
    [self.view addSubview:self.imageView];
    
    [self.linkView sd_setImageWithURL:url1 placeholderImage:nil options:SDWebImageFromLoaderOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"%@", @"LPLinkView metadata load success");
    }];
    [self.imageView sd_setImageWithURL:url2 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"%@", @"UIImageView image load success");
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.linkView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2);
    self.imageView.frame = CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height / 2);
}

@end
