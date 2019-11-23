/*
 * This file is part of the SDWebImagePhotosPlugin package.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDTestCase.h"

@interface SDPhotosPluginTests : SDTestCase

@end

@implementation SDPhotosPluginTests

+ (void)setUp {
    [SDImageLoadersManager.sharedManager addLoader:SDImageLinkLoader.sharedLoader];
    SDWebImageManager.defaultImageLoader = SDImageLoadersManager.sharedManager;
}

- (void)testUIImageViewSetImageWithURL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UIImageView setImageWithURL"];
    NSURL *linkURL = [NSURL URLWithString:@"https://www.apple.com/"];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:linkURL
                 placeholderImage:nil
                          options:SDWebImageFromLoaderOnly
                          context:nil
                         progress:nil
                        completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            expect(image).toNot.beNil();
                            expect(error).to.beNil();
                            expect(linkURL).to.equal(imageURL);
                            expect(imageView.image).to.equal(image);
                            [expectation fulfill];
                        }];
    [self waitForExpectationsWithTimeout:kAsyncTestTimeout handler:nil];
}

- (void)testLPLinkViewSetImageWithURL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"LPLinkView setImageWithURL"];
    NSURL *linkURL = [NSURL URLWithString:@"https://www.apple.com/"];
    
    NSURL *emptyURL = nil;
    LPLinkView *linkView = [[LPLinkView alloc] initWithURL:emptyURL];
    [linkView sd_setImageWithURL:linkURL
                 placeholderImage:nil
                          options:SDWebImageFromLoaderOnly
                          context:nil
                         progress:nil
                        completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            LPLinkMetadata *metadata = imageURL.sd_linkMetadata;
                            expect(metadata).toNot.beNil();
                            expect(image).toNot.beNil();
                            expect(error).to.beNil();
                            expect(linkURL).to.equal(imageURL);
                            expect(metadata.originalURL).equal(linkURL);
                            [expectation fulfill];
                        }];
    [self waitForExpectationsWithTimeout:kAsyncTestTimeout handler:nil];
}

@end
