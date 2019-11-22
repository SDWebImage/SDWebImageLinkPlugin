//
//  NSImage+SDWebImageLinkPlugin.h
//  Pods-SDWebImageLinkPlugin_Example
//
//  Created by 李卓立 on 2019/11/22.
//

@import SDWebImage;

#if SD_MAC

/// Make NSImage supports the `NSItemProviderReading` as well as UIKit's UIImage
@interface NSImage (SDWebImageLinkPlugin) <NSItemProviderReading, NSItemProviderWriting>

@end

#endif
