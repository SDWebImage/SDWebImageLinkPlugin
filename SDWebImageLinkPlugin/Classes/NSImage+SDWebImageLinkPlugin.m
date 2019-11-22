//
//  NSImage+SDWebImageLinkPlugin.m
//  Pods-SDWebImageLinkPlugin_Example
//
//  Created by 李卓立 on 2019/11/22.
//

#import "NSImage+SDWebImageLinkPlugin.h"

#if SD_MAC

@implementation NSImage (SDWebImageLinkPlugin)

#pragma mark - NSItemProviderReading

+ (instancetype)objectWithItemProviderData:(NSData *)data typeIdentifier:(NSString *)typeIdentifier error:(NSError *__autoreleasing  _Nullable *)outError {
    return [[NSImage alloc] initWithData:data];
}

+ (NSArray<NSString *> *)readableTypeIdentifiersForItemProvider {
    return [NSImage imageTypes];
}

#pragma mark - NSItemProviderWriting

+ (NSArray<NSString *> *)writableTypeIdentifiersForItemProvider {
    return [NSImage imageTypes];
}

- (nullable NSProgress *)loadDataWithTypeIdentifier:(nonnull NSString *)typeIdentifier forItemProviderCompletionHandler:(nonnull void (^)(NSData * _Nullable, NSError * _Nullable))completionHandler {
    NSRect imageRect = NSMakeRect(0, 0, self.size.width, self.size.height);
    NSImageRep *imageRep = [self bestRepresentationForRect:imageRect context:nil hints:nil];
    NSBitmapImageRep *bitmapImageRep;
    if ([imageRep isKindOfClass:[NSBitmapImageRep class]]) {
        bitmapImageRep = (NSBitmapImageRep *)imageRep;
    } else {
        bitmapImageRep = [[NSBitmapImageRep alloc] initWithCGImage:self.CGImage];
    }
    NSBitmapImageFileType fileType;
    if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeJPEG]) {
        fileType = NSBitmapImageFileTypeJPEG;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeJPEG2000]) {
        fileType = NSBitmapImageFileTypeJPEG2000;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypePNG]) {
        fileType = NSBitmapImageFileTypePNG;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeBMP]) {
        fileType = NSBitmapImageFileTypeBMP;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeGIF]) {
        fileType = NSBitmapImageFileTypeGIF;
    } else if ([typeIdentifier isEqualToString:(__bridge NSString *)kUTTypeTIFF]) {
        fileType = NSBitmapImageFileTypeTIFF;
    }
    NSData *imageData = [bitmapImageRep representationUsingType:NSBitmapImageFileTypeJPEG properties:@{}];
    if (completionHandler) {
        completionHandler(imageData, nil);
    }
    
    return nil;
}

@end

#endif
