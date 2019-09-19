//
//	LYAddCommentManager.h
//  LYExtension
//
//  Created by LiuY on 2019/9/18.
//  Copyright © 2019 DeveloperLY. All rights reserved.
//   

#import <XcodeKit/XcodeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAddCommentManager : NSObject

+ (instancetype)sharedInstance;

- (void)processCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end

NS_ASSUME_NONNULL_END
