//
//	NSString+LYExtension.h
//  LYExtension
//
//  Created by LiuY on 2019/9/18.
//  Copyright © 2019 DeveloperLY. All rights reserved.
//   

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYExtension)

/*
 * 返回中间字符串
 * 如果 leftStr 为 nil , 则返回 rightStr 之前的字符串
 */
- (NSString *)stringBetweenLeftStr:(nullable NSString *)leftStr andRightStr:(nullable NSString *)rightStr;

// 删除空格和换行符
- (NSString *)deleteSpaceAndNewLine;

// 获取类型字符串
- (NSString *)fetchClassNameStr;

// 获取属性名
- (NSString *)fetchPropertyNameStr;

- (BOOL)checkHasContainsOneOfStrs:(NSArray *)strArray andNotContainsOneOfStrs:(NSArray *)noHasStrsArray;

@end

NS_ASSUME_NONNULL_END
