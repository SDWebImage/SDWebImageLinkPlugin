//
//  NSImage+SDWebImageLinkPlugin.m
//  Pods-SDWebImageLinkPlugin_Example
//
//  Created by 李卓立 on 2019/11/22.
//

#import "NSImage+SDWebImageLinkPlugin.h"

#if SD_MAC

@implementation NSImage (SDWebImageLinkPlugin)

+ (instancetype)objectWithItemProviderData:(NSData *)data typeIdentifier:(NSString *)typeIdentifier error:(NSError *__autoreleasing  _Nullable *)outError {
    return [[NSImage alloc] initWithData:data];
}

+ (NSArray<NSString *> *)readableTypeIdentifiersForItemProvider {
    return [NSImage imageTypes];
}

@end

#endif
