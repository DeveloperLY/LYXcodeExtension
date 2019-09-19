//
//	LYInitViewManager.m
//  LYExtension
//
//  Created by LiuY on 2019/9/18.
//  Copyright © 2019 DeveloperLY. All rights reserved.
//   

#import "LYInitViewManager.h"
#import "LYExtensionConst.h"

static LYInitViewManager *_instance = nil;

@interface LYInitViewManager ()

@property (nonatomic, strong) NSMutableIndexSet *indexSet;

@end

@implementation LYInitViewManager

+ (instancetype)sharedInstance {
    if (!_instance) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}


- (void)processCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation {
    [self.indexSet removeAllIndexes];
    
    // 添加 extension 代码
    NSString *className = [invocation.buffer.lines fetchClassName];
    if ([invocation.buffer.lines indexOfFirstItemContainStr:[NSString stringWithFormat:@"@interface %@ ()", className]] == NSNotFound) {
        NSString *extensionStr = [NSString stringWithFormat:kInitViewExtensionCode, className];
        NSArray *contentArray = [extensionStr componentsSeparatedByString:@"\n"];
        NSInteger impIndex = [invocation.buffer.lines indexOfFirstItemContainStr:kImplementation];
        [invocation.buffer.lines insertItemsOfArray:contentArray fromIndex:impIndex];
    }
    
    if ([[className lowercaseString] hasSuffix:@"view"] ||
        [[className lowercaseString] hasSuffix:@"bar"] ||
        [[className lowercaseString] hasSuffix:@"collectioncell"] ||
        [[className lowercaseString] hasSuffix:@"collectionviewcell"]) {
        // 添加 Life Cycle 代码
        if ([invocation.buffer.lines indexOfFirstItemContainStr:@"- (instancetype)initWithFrame"] == NSNotFound) {
            [self deleteCodeWithInvocation:invocation];
            NSInteger lifeCycleIndex = [invocation.buffer.lines indexOfFirstItemContainStr:kImplementation];
            if (lifeCycleIndex != NSNotFound) {
                lifeCycleIndex = lifeCycleIndex + 1;
                NSString *lifeCycleStr = kInitViewLifeCycleCode;
                NSArray *lifeCycleContentArray = [lifeCycleStr componentsSeparatedByString:@"\n"];
                [invocation.buffer.lines insertItemsOfArray:lifeCycleContentArray fromIndex:lifeCycleIndex];
            }
        }
    } else if ([[className lowercaseString] hasSuffix:@"tableviewcell"] ||
               [[className lowercaseString] hasSuffix:@"tablecell"]) {
        // 添加 Life Cycle 代码
        if ([invocation.buffer.lines indexOfFirstItemContainStr:@"(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier"] == NSNotFound) {
            [self deleteCodeWithInvocation:invocation];
            NSInteger lifeCycleIndex = [invocation.buffer.lines indexOfFirstItemContainStr:kImplementation];
            if (lifeCycleIndex != NSNotFound) {
                lifeCycleIndex = lifeCycleIndex + 1;
                NSString *lifeCycleStr = kInitTableViewCellLifeCycleCode;
                NSArray *lifeCycleContentArray = [lifeCycleStr componentsSeparatedByString:@"\n"];
                [invocation.buffer.lines insertItemsOfArray:lifeCycleContentArray fromIndex:lifeCycleIndex];
            }
        }
    } else if ([[className lowercaseString] hasSuffix:@"controller"] ||
               [className hasSuffix:@"VC"] ||
               [className hasSuffix:@"Vc"]) {
        // 添加 Life Cycle 代码
        if ([invocation.buffer.lines indexOfFirstItemContainStr:kGetterSetterPragmaMark] == NSNotFound) {
            [self deleteCodeWithInvocation:invocation];
            NSInteger lifeCycleIndex = [invocation.buffer.lines indexOfFirstItemContainStr:kImplementation];
            if (lifeCycleIndex != NSNotFound) {
                lifeCycleIndex = lifeCycleIndex + 1;
                NSString *lifeCycleStr = kInitViewControllerLifeCycleCode;
                NSArray *lifeCycleContentArray = [lifeCycleStr componentsSeparatedByString:@"\n"];
                [invocation.buffer.lines insertItemsOfArray:lifeCycleContentArray fromIndex:lifeCycleIndex];
            }
        }
    }
    
}

- (void)deleteCodeWithInvocation:(XCSourceEditorCommandInvocation *)invocation {
    NSInteger impIndex = [invocation.buffer.lines indexOfFirstItemContainStr:kImplementation];
    NSInteger endIndex = [invocation.buffer.lines indexOfFirstItemContainStr:kEnd fromIndex:impIndex];
    if (impIndex != NSNotFound && endIndex != NSNotFound) {
        for (NSInteger i = impIndex + 1; i < endIndex - 1; i++) {
            NSString *contentStr = [invocation.buffer.lines[i] deleteSpaceAndNewLine];
            if ([contentStr length]) {
                [self.indexSet addIndex:i];
            }
        }
    }
    if ([self.indexSet count]) {
        [invocation.buffer.lines removeObjectsAtIndexes:self.indexSet];
    }
}


- (NSMutableIndexSet *)indexSet {
    if (!_indexSet) {
        _indexSet = [[NSMutableIndexSet alloc] init];
    }
    return _indexSet;
}

@end
