//
//	SourceEditorExtension.m
//  LYExtension
//
//  Created by LiuY on 2019/9/18.
//  Copyright © 2019 DeveloperLY. All rights reserved.
//   

#import "SourceEditorExtension.h"

@implementation SourceEditorExtension

/*
- (void)extensionDidFinishLaunching {
    // If your extension needs to do any work at launch, implement this optional method.
}
*/

- (NSArray <NSDictionary <XCSourceEditorCommandDefinitionKey, id> *> *)commandDefinitions {
    // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
    return @[@{XCSourceEditorCommandClassNameKey: @"SourceEditorCommand",
               XCSourceEditorCommandIdentifierKey: @"net.developerly.LYXcodeExtension.LYExtension.initView",
               XCSourceEditorCommandNameKey: @"InitView"
               },
             @{XCSourceEditorCommandClassNameKey: @"SourceEditorCommand",
               XCSourceEditorCommandIdentifierKey: @"net.developerly.LYXcodeExtension.LYExtension.addLazyCode",
               XCSourceEditorCommandNameKey: @"AddLazyCode"
               },
             @{XCSourceEditorCommandClassNameKey: @"SourceEditorCommand",
               XCSourceEditorCommandIdentifierKey: @"net.developerly.LYXcodeExtension.LYExtension.addImport",
               XCSourceEditorCommandNameKey: @"AddImport"
               },
             @{XCSourceEditorCommandClassNameKey: @"SourceEditorCommand",
               XCSourceEditorCommandIdentifierKey: @"net.developerly.LYXcodeExtension.LYExtension.sortImport",
               XCSourceEditorCommandNameKey: @"SortImport"
               }];
}

@end
