/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

#import "NSURL+SDWebImageLinkPlugin.h"
#import <objc/runtime.h>

#define SD_SET_WEAK(property) id __weak __weak_object = property; \
  id (^__weak_block)(void) = ^{ return __weak_object; }; \
  objc_setAssociatedObject(self, @selector(property), __weak_block, OBJC_ASSOCIATION_COPY);

#define SD_GET_WEAK(property) objc_getAssociatedObject(self, @selector(property)) ? ((id (^)(void))objc_getAssociatedObject(self, @selector(property)))() : nil;

@implementation NSURL (SDWebImageLinkPlugin)

- (LPLinkMetadata *)sd_linkMetadata {
    return SD_GET_WEAK(sd_linkMetadata);
}

- (void)setSd_linkMetadata:(LPLinkMetadata *)sd_linkMetadata {
    SD_SET_WEAK(sd_linkMetadata);
}

@end
