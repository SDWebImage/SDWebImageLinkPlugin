/*
* This file is part of the SDWebImage package.
* (c) Olivier Poitrey <rs@dailymotion.com>
*
* For the full copyright and license information, please view the LICENSE
* file that was distributed with this source code.
*/

#import "SDImageLinkLoader.h"
#import "SDWebImageLinkDefine.h"
#import "SDWebImageLinkError.h"
#import <LinkPresentation/LinkPresentation.h>
#if SD_UIKIT
#import <MobileCoreServices/MobileCoreServices.h>
#endif

@interface LPMetadataProvider (SDWebImageLinkPlugin) <SDWebImageOperation>

@end

#if SD_MAC
@interface NSImage (SDWebImageLinkPlugin) <NSItemProviderReading>

@end
#endif

@interface SDImageLinkLoader ()

@end

@implementation SDImageLinkLoader

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (SDImageLinkLoader *)sharedLoader {
    static SDImageLinkLoader *loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[SDImageLinkLoader alloc] init];
    });
    return loader;
}

#pragma mark - SDImageLoader

- (BOOL)canRequestImageForURL:(NSURL *)url {
    return YES;
}

- (id<SDWebImageOperation>)requestImageWithURL:(NSURL *)url options:(SDWebImageOptions)options context:(SDWebImageContext *)context progress:(SDImageLoaderProgressBlock)progressBlock completed:(SDImageLoaderCompletedBlock)completedBlock {
    
    LPMetadataProvider *provider = [[LPMetadataProvider alloc] init];
    [provider startFetchingMetadataForURL:url completionHandler:^(LPLinkMetadata * _Nullable metadata, NSError * _Nullable error) {
        if (error) {
            if (completedBlock) {
                completedBlock(nil, nil, error, YES);
            }
            return;
        }
        NSItemProvider *imageProvider = metadata.imageProvider;
        if (!imageProvider) {
            // Check icon provider as a backup
            NSItemProvider *iconProvider = metadata.iconProvider;
            if (!iconProvider) {
                // No image to query, failed
                if (completedBlock) {
                    NSError *error = [NSError errorWithDomain:SDWebImageLinkErrorDomain code:SDWebImageLinkErrorNoImageProvider userInfo:nil];
                    completedBlock(nil, nil, error, YES);
                }
                return;
            }
            imageProvider = iconProvider;
        }
        [self fetchImageProvider:imageProvider url:url options:options context:context completed:completedBlock];
    }];
    
    return provider;
}

- (void)fetchImageProvider:(NSItemProvider *)imageProvider url:(NSURL *)url options:(SDWebImageOptions)options context:(SDWebImageContext *)context completed:(SDImageLoaderCompletedBlock)completedBlock {
    BOOL requestData = [context[SDWebImageContextLinkRequestImageData] boolValue];
    
    if (requestData) {
        // Request the image data and decode
        [imageProvider loadDataRepresentationForTypeIdentifier:(__bridge NSString *)kUTTypeImage completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (error) {
                return;
            }
            // This is global queue, decode it
            UIImage *image = SDImageLoaderDecodeImageData(data, url, options, context);
            if (completedBlock) {
                if (image) {
                    dispatch_main_async_safe(^{
                        completedBlock(image, data, nil, YES);
                    });
                } else {
                    NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:SDWebImageErrorBadImageData userInfo:nil];
                    dispatch_main_async_safe(^{
                        completedBlock(nil, nil, error, YES);
                    });
                }
            }
        }];
    } else {
        // Only request the image object, faster
        [imageProvider loadObjectOfClass:UIImage.class completionHandler:^(UIImage * _Nullable image, NSError * _Nullable error) {
            if (error) {
                return;
            }
            NSAssert([image isKindOfClass:UIImage.class], @"NSItemProvider fetched object should be UIImage class");
            if (completedBlock) {
                if (image) {
                    dispatch_main_async_safe(^{
                        completedBlock(image, nil, error, YES);
                    });
                } else {
                    NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:SDWebImageErrorBadImageData userInfo:nil];
                    dispatch_main_async_safe(^{
                        completedBlock(nil, nil, error, YES);
                    });
                }
            }
        }];
    }
}

- (BOOL)shouldBlockFailedURLWithURL:(NSURL *)url error:(NSError *)error {
    BOOL shouldBlockFailedURL = NO;
    if ([error.domain isEqualToString:SDWebImageErrorDomain]) {
        shouldBlockFailedURL = (   error.code == SDWebImageErrorInvalidURL
                                || error.code == SDWebImageErrorBadImageData);
    }
    return shouldBlockFailedURL;
}

@end
