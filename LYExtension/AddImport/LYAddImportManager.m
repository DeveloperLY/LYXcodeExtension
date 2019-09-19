//
//	LYAddImportManager.m
//  LYExtension
//
//  Created by LiuY on 2019/9/18.
//  Copyright © 2019 DeveloperLY. All rights reserved.
//   

#import "LYAddImportManager.h"
#import "LYExtensionConst.h"

static LYAddImportManager *_instance = nil;

@implementation LYAddImportManager

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
    if (![invocation.buffer.selections count]) {
        return;
    }
    
    XCSourceTextRange *selectRange = invocation.buffer.selections[0];
    NSInteger startLine = selectRange.start.line;
    NSInteger endLine = selectRange.end.line;
    NSInteger startColumn = selectRange.start.column;
    NSInteger endColumn = selectRange.end.column;
    
    if (startLine != endLine || startColumn == endColumn) {
        return;
    }
    
    NSString *selectLineStr = invocation.buffer.lines[startLine];
    NSString *selectContentStr = [[selectLineStr substringWithRange:NSMakeRange(startColumn, endColumn - startColumn)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([selectContentStr length] == 0) {
        return;
    }
    NSString *insertStr = [NSString stringWithFormat:@"#import \"%@.h\"", selectContentStr];
    
    NSInteger lastImportIndex = -1;
    for (NSInteger i = 0; i < [invocation.buffer.lines count]; i++) {
        NSString *contentStr = [invocation.buffer.lines[i] deleteSpaceAndNewLine];
        if ([contentStr hasPrefix:@"#import"]) {
            lastImportIndex = i;
        }
    }
    
    NSInteger alreadyIndex = [invocation.buffer.lines indexOfFirstItemContainStr:insertStr];
    if (alreadyIndex != NSNotFound) {
        return;
    }
    
    NSInteger insertIndex = 0;
    if (lastImportIndex != -1) {
        insertIndex = lastImportIndex + 1;
    }
    [invocation.buffer.lines insertObject:insertStr atIndex:insertIndex];
}

@end
