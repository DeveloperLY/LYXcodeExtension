//
//	LYAddLazyCodeManager.h
//  LYExtension
//
//  Created by LiuY on 2019/9/18.
//  Copyright © 2019 DeveloperLY. All rights reserved.
//   

#import <XcodeKit/XcodeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAddLazyCodeManager : NSObject

+ (instancetype)sharedInstance;

/**
 自动添加视图布局 && 设置Getter方法 && 自动AddSubView
 @param invocation 获取选中的字符流
 */
- (void)processCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end

NS_ASSUME_NONNULL_END
