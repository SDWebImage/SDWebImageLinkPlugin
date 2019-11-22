# SDWebImageLinkPlugin

[![CI Status](https://img.shields.io/travis/SDWebImage/SDWebImageLinkPlugin.svg?style=flat)](https://travis-ci.org/SDWebImage/SDWebImageLinkPlugin)
[![Version](https://img.shields.io/cocoapods/v/SDWebImageLinkPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImageLinkPlugin)
[![License](https://img.shields.io/cocoapods/l/SDWebImageLinkPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImageLinkPlugin)
[![Platform](https://img.shields.io/cocoapods/p/SDWebImageLinkPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImageLinkPlugin)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/SDWebImage/SDWebImageLinkPlugin)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager/)
[![codecov](https://codecov.io/gh/SDWebImage/SDWebImageLinkPlugin/branch/master/graph/badge.svg)](https://codecov.io/gh/SDWebImage/SDWebImageLinkPlugin)

## What's for
SDWebImageLinkPlugin is a plugin for [SDWebImage](https://github.com/rs/SDWebImage/) framework, which provide the image loading support for rich link URL, by using the [Link Presentation](https://developer.apple.com/documentation/linkpresentation) framework introduced in iOS 13/macOS 10.15.

By using this plugin, it allows you to use your familiar View Category method from SDWebImage, to load rich link's poster image, with the URL or `LPMetadata`. And make it easy to use `LPLinkView` with cache support.

## Requirements

+ iOS 13+
+ macOS 10.15+
+ Xcode 11+

## Installation

#### CocoaPods

SDWebImageLinkPlugin is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SDWebImageLinkPlugin'
```

#### Carthage

SDWebImageLinkPlugin is available through [Carthage](https://github.com/Carthage/Carthage).

```
github "SDWebImage/SDWebImageLinkPlugin"
```

#### Swift Package Manager (Xcode 11+)

SDWebImageLinkPlugin is available through [Swift Package Manager](https://swift.org/package-manager).

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImageLinkPlugin.git", from: "0.1")
    ]
)
```

## Usage

#### Setup Loader

To use the LinkPlugin, you should setup the loader firstly. See more here in [Wiki - Loaders Manager](https://github.com/SDWebImage/SDWebImage/wiki/Advanced-Usage#loaders-manager)

+ Objective-C

```objective-c
[SDImageLoadersManager.sharedManager addLoader:SDImageLinkLoader.sharedLoader];
SDWebImageManager.defaultImageLoader = SDImageLoadersManager.sharedManager;
```

#### Load Rich Link on UIImageView/LPLinkView

The simple and fast usage, it to use the LinkPlugin provided category on `UIImageView` and `LPLinkView`.

+ Objective-C

```objectivec
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
```

Note: You can always read and write the `LPMetadata` object on the associated `NSURL` object, to provide an exist metadata from your serialization solution, or update the metadata. If the provided URL have an associated metadata, we don't do extra query with [LPMetadataProvider](https://developer.apple.com/documentation/linkpresentation/lpmetadataprovider?language=objc).

+ Objective-C

```objective-c
LPLinkMetadata *metadata = imageURL.sd_linkMetadata;
NSLog(@"[title]: %@\n[url]: %@\n[image]: %@", metadata.title, metadata.URL, metadata.imageProvider);
```

Note: By default, we prefer to load the image only, which does not generate the image data. This can increase the loading speed. But however, you can also specify to generate the image data by using `SDWebImageContextLinkRequestImageData` context option.

## Demo

If you have some issue about usage, SDWebImageLinkPlugin provide a demo for iOS && macOS platform. To run the demo, clone the repo and run the following command.

```bash
cd Example/
pod install
open SDWebImageLinkPlugin.xcworkspace
```

After the Xcode project was opened, click `Run` to build and run the demo.

## Screenshot

<img src="https://raw.githubusercontent.com/SDWebImage/SDWebImageLinkPlugin/master/Example/Screenshot/LinkDemo.png" width="300" />
<img src="https://raw.githubusercontent.com/SDWebImage/SDWebImageLinkPlugin/master/Example/Screenshot/LinkDemo-macOS.png" width="600" />

These rich link image is from the [Apple site](https://www.apple.com/) and [WebKit site](https://webkit.org/).

## Author

DreamPiggy

## License

SDWebImageLinkPlugin is available under the MIT license. See the LICENSE file for more info.
