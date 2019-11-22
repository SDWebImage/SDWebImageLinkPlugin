/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

@import SDWebImage;
@import LinkPresentation;

@interface NSURL (SDWebImageLinkPlugin)

/// A URL can have its associated link metadata, this is a weak reference. (`LPLinkMetadata` retain the `NSURL`, and `NSURL` can weak reference the `LPLinkMetadata`)
@property (nonatomic, weak) LPLinkMetadata *sd_linkMetadata;

@end
