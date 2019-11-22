/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

@import SDWebImage;

/**
 A Bool value specify whether or not, to request the metadata's image, with the Data representation. But default we do not keep data by using `loadObjectOfClass` API. If enable, we'll use `loadDataRepresentationForTypeIdentifier` API instead, and decode the data into image object.
 @note Current implementation, LinkPresentation can retrive UIImage object 5x faster than the Data, so by default, we only request the image object witthout data. But it depends on your own usage, you can trun this on. (NSNumber *)
 */
FOUNDATION_EXPORT SDWebImageContextOption _Nonnull const SDWebImageContextLinkRequestImageData;
