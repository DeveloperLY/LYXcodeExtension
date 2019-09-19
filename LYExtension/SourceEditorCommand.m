//
//	SourceEditorCommand.m
//  LYExtension
//
//  Created by LiuY on 2019/9/18.
//  Copyright © 2019 DeveloperLY. All rights reserved.
//   

#import "SourceEditorCommand.h"
#import "LYInitViewManager.h"
#import "LYAddLazyCodeManager.h"
#import "LYSortImportManager.h"
#import "LYAddImportManager.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    NSString *identifier = invocation.commandIdentifier;
    [invocation.buffer.lines enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    if ([identifier hasPrefix:@"net.developerly.LYXcodeExtension.LYExtension.sortImport"]) {
        [[LYSortImportManager sharedInstance] processCodeWithInvocation:invocation];
    } else if ([identifier hasPrefix:@"net.developerly.LYXcodeExtension.LYExtension.initView"]) {
        [[LYInitViewManager sharedInstance] processCodeWithInvocation:invocation];
    } else if ([identifier hasPrefix:@"net.developerly.LYXcodeExtension.LYExtension.addLazyCode"]) {
        [[LYAddLazyCodeManager sharedInstance] processCodeWithInvocation:invocation];
    } else if ([identifier hasPrefix:@"net.developerly.LYXcodeExtension.LYExtension.addImport"]) {
        [[LYAddImportManager sharedInstance] processCodeWithInvocation:invocation];
    }
    completionHandler(nil);
}

@end
