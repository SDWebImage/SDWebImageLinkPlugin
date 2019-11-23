//
//  ViewController.m
//  SDWebImageLinkPlugin_Example macOS
//
//  Created by 李卓立 on 2019/11/22.
//  Copyright © 2019 lizhuoli1126@126.com. All rights reserved.
//

#import "ViewController.h"
#import <LinkPresentation/LinkPresentation.h>
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageLinkPlugin/SDWebImageLinkPlugin.h>

@interface ViewController ()

@property (nonatomic, strong) LPLinkView *linkView;
@property (nonatomic, strong) NSImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url1 = [NSURL URLWithString:@"https://www.apple.com/mac/"];
    NSURL *url2 = [NSURL URLWithString:@"https://webkit.org/"];
    self.linkView = [[LPLinkView alloc] initWithURL:url1];
    self.imageView = [[NSImageView alloc] init];
    self.imageView.imageScaling = NSImageScaleProportionallyUpOrDown;
    [self.view addSubview:self.linkView];
    [self.view addSubview:self.imageView];
    
    [self.linkView sd_setImageWithURL:url1 placeholderImage:nil options:0 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"%@", @"LPLinkView metadata load success");
    }];
    [self.imageView sd_setImageWithURL:url2 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"%@", @"UIImageView image load success");
    }];
}

- (void)viewDidLayout {
    [super viewDidLayout];
    self.linkView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2);
    self.imageView.frame = CGRectMake(0, self.view.bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height / 2);
}

@end
