/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const SDWebImageLinkErrorDomain;

typedef NS_ERROR_ENUM(SDWebImageLinkErrorDomain, SDWebImageLinkError) {
    SDWebImageLinkErrorNoImageProvider = 10000, // Metadata have no any ImageProvider or IconProvider to query
};
NS_ASSUME_NONNULL_END
