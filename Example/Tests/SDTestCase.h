/*
 * This file is part of the SDWebImagePhotosPlugin package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#define EXP_SHORTHAND   // required by Expecta


#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageLinkPlugin/SDWebImageLinkPlugin.h>

FOUNDATION_EXPORT const int64_t kAsyncTestTimeout;
FOUNDATION_EXPORT const int64_t kMinDelayNanosecond;

@interface SDTestCase : XCTestCase

- (void)waitForExpectationsWithCommonTimeout;
- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(nullable XCWaitCompletionHandler)handler;

@end
