/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

@import SDWebImage;

#if SD_MAC

/// Make NSImage supports the `NSItemProviderReading` as well as UIKit's UIImage
@interface NSImage (SDWebImageLinkPlugin) <NSItemProviderReading, NSItemProviderWriting>

@end

#endif
