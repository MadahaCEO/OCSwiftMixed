//
//  NSString+MDHPinYin4Cocoa.h
//  MDHPinYin4Cocoa
//
//  Created by kimziv on 13-9-15.
//  Copyright (c) 2013年 kimziv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PinYin4Cocoa)

- (NSInteger)mdh_indexOfString:(NSString *)s;
- (NSInteger)mdh_indexOfString:(NSString *)s fromIndex:(int)index;
- (NSInteger)mdh_indexOf:(int)ch;
- (NSInteger)mdh_indexOf:(int)ch fromIndex:(int)index;
+ (NSString *)mdh_valueOfChar:(unichar)value;

-(NSString *)mdh_stringByReplacingRegexPattern:(NSString *)regex
                                    withString:(NSString *)replacement;
-(NSString *)mdh_stringByReplacingRegexPattern:(NSString *)regex
                                    withString:(NSString *)replacement
                               caseInsensitive:(BOOL) ignoreCase;
-(NSString *)mdh_stringByReplacingRegexPattern:(NSString *)regex
                                 withString:(NSString *)replacement
                            caseInsensitive:(BOOL)ignoreCase
                             treatAsOneLine:(BOOL)assumeMultiLine;
-(NSArray *)mdh_stringsByExtractingGroupsUsingRegexPattern:(NSString *)regex;
-(NSArray *)mdh_stringsByExtractingGroupsUsingRegexPattern:(NSString *)regex
                                           caseInsensitive:(BOOL)ignoreCase
                                            treatAsOneLine:(BOOL)assumeMultiLine;
-(BOOL)mdh_matchesPatternRegexPattern:(NSString *)regex;
-(BOOL)mdh_matchesPatternRegexPattern:(NSString *)regex
                   caseInsensitive:(BOOL)ignoreCase
                    treatAsOneLine:(BOOL)assumeMultiLine;
@end
