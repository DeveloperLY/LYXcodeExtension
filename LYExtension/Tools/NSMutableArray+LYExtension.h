//
//	NSMutableArray+LYExtension.h
//  LYExtension
//
//  Created by LiuY on 2019/9/18.
//  Copyright © 2019 DeveloperLY. All rights reserved.
//   

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (LYExtension)

- (NSInteger)indexOfFirstItemContainStrsArray:(NSArray *)strsArray;

- (NSInteger)indexOfFirstItemContainStr:(NSString *)str;

- (NSInteger)indexOfFirstItemContainStr:(NSString *)str fromIndex:(NSInteger)fromIndex;

- (NSInteger)indexOfFirstItemContainStr:(NSString *)str fromIndex:(NSInteger)fromIndex andToIndex:(NSInteger)toIndex;

- (void)insertItemsOfArray:(NSArray *)itemsArray fromIndex:(NSInteger)insertIndex;

- (NSString *)fetchClassName;

- (NSString *)fetchCurrentClassNameWithCurrentIndex:(NSInteger)currentIndex;

- (void)deleteItemsFromFirstItemContains:(NSString *)firstStr andLastItemsContainsStr:(NSString *)lastStr;

- (void)printList;

- (NSMutableArray *)arrayWithNoSameItem;

@end

NS_ASSUME_NONNULL_END
