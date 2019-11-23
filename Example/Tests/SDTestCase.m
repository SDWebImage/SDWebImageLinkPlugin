/*
 * This file is part of the SDWebImagePhotosPlugin package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDTestCase.h"

const int64_t kAsyncTestTimeout = 5;
const int64_t kMinDelayNanosecond = NSEC_PER_MSEC * 100; // 0.1s

@implementation SDTestCase

- (void)waitForExpectationsWithCommonTimeout {
    [self waitForExpectationsWithCommonTimeoutUsingHandler:nil];
}

- (void)waitForExpectationsWithCommonTimeoutUsingHandler:(XCWaitCompletionHandler)handler {
    [self waitForExpectationsWithTimeout:kAsyncTestTimeout handler:handler];
}

@end
