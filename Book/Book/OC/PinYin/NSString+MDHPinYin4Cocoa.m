//
//  NSString+MDHPinYin4Cocoa.m
//  MDHPinYin4Cocoa
//
//  Created by kimziv on 13-9-15.
//  Copyright (c) 2013年 kimziv. All rights reserved.
//

#import "NSString+MDHPinYin4Cocoa.h"

#ifdef DEBUG
#define PYLog(...) NSLog(__VA_ARGS__)
#else
#define PYLog(__unused ...)
#endif

@implementation NSString (MDHPinYin4Cocoa)


- (NSInteger)mdh_indexOfString:(NSString *)s {
    NSAssert3((s!=nil), @"Error, s is a nil string, %s, %s, %d", __FILE__, __FUNCTION__, __LINE__);
    if ([s length] == 0) {
        return 0;
    }
    NSRange range = [self rangeOfString:s];
    return range.location == NSNotFound ? -1 : (int) range.location;
}


- (NSInteger)mdh_indexOfString:(NSString *)s fromIndex:(int)index {
    NSAssert3((s!=nil), @"Error, s is a nil string, %s, %s, %d", __FILE__, __FUNCTION__, __LINE__);
    if ([s length] == 0) {
        return 0;
    }
    NSRange searchRange = NSMakeRange((NSUInteger) index,
                                      [self length] - (NSUInteger) index);
    NSRange range = [self rangeOfString:s
                                options:NSLiteralSearch
                                  range:searchRange];
    return range.location == NSNotFound ? -1 : (int) range.location;
}

- (NSInteger)mdh_indexOf:(int)ch {
    //    unichar c = (unichar) ch;
    //    for(int i=0;i<self.length;i++)
    //        if(c == [self characterAtIndex:i])
    //            return i;
    //    return -1;
    return [self mdh_indexOf:ch fromIndex:0];
}

- (NSInteger)mdh_indexOf:(int)ch fromIndex:(int)index {
    unichar c = (unichar) ch;
    NSString *s = [NSString stringWithCharacters:&c length:1];
    return [self mdh_indexOfString:s fromIndex:(int)index];
}

+ (NSString *)mdh_valueOfChar:(unichar)value {
    return [NSString stringWithFormat:@"%C", value];
}

-(NSString *)mdh_stringByReplacingRegexPattern:(NSString *)regex
                                    withString:(NSString *)replacement
                               caseInsensitive:(BOOL)ignoreCase {
    
    return [self mdh_stringByReplacingRegexPattern:regex
                                        withString:replacement
                                   caseInsensitive:ignoreCase
                                    treatAsOneLine:NO];
}

-(NSString *)mdh_stringByReplacingRegexPattern:(NSString *)regex
                                    withString:(NSString *)replacement
                               caseInsensitive:(BOOL)ignoreCase
                                treatAsOneLine:(BOOL)assumeMultiLine {
    
    NSUInteger options=0;
    if (ignoreCase) {
        options = options | NSRegularExpressionCaseInsensitive;
    }
    if (assumeMultiLine) {
        options = options | NSRegularExpressionDotMatchesLineSeparators;
    }
    
    NSError *error=nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error) {
        PYLog(@"Error creating Regex: %@",[error description]);
        return nil;
    }
    
    NSString *retVal= [pattern stringByReplacingMatchesInString:self
                                                        options:0
                                                          range:NSMakeRange(0, [self length])
                                                   withTemplate:replacement];
    return retVal;
}

-(NSString *)mdh_stringByReplacingRegexPattern:(NSString *)regex
                                    withString:(NSString *) replacement {
    return [self mdh_stringByReplacingRegexPattern:regex
                                        withString:replacement
                                   caseInsensitive:NO
                                    treatAsOneLine:NO];
}

-(NSArray *)mdh_stringsByExtractingGroupsUsingRegexPattern:(NSString *)regex
                                           caseInsensitive:(BOOL)ignoreCase
                                            treatAsOneLine:(BOOL)assumeMultiLine {
    NSUInteger options=0;
    if (ignoreCase) {
        options = options | NSRegularExpressionCaseInsensitive;
    }
    if (assumeMultiLine) {
        options = options | NSRegularExpressionDotMatchesLineSeparators;
    }
    
    NSError *error=nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error) {
        PYLog(@"Error creating Regex: %@",[error description]);
        return nil;
    }
    
    __block NSMutableArray *retVal = [NSMutableArray array];
    [pattern enumerateMatchesInString:self options:0 range:NSMakeRange(0, [self length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        //Note, we only want to return the things in parens, so we're skipping index 0 intentionally
        for (int i=1; i<[result numberOfRanges]; i++) {
            NSString *matchedString=[self substringWithRange:[result rangeAtIndex:i]];
            [retVal addObject:matchedString];
        }
    }];
    return retVal;
}

-(NSArray *)mdh_stringsByExtractingGroupsUsingRegexPattern:(NSString *)regex {
    return [self mdh_stringsByExtractingGroupsUsingRegexPattern:regex caseInsensitive:NO treatAsOneLine:NO];
}

-(BOOL)mdh_matchesPatternRegexPattern:(NSString *)regex
                      caseInsensitive:(BOOL)ignoreCase
                       treatAsOneLine:(BOOL)assumeMultiLine {
    NSUInteger options=0;
    if (ignoreCase) {
        options = options | NSRegularExpressionCaseInsensitive;
    }
    if (assumeMultiLine) {
        options = options | NSRegularExpressionDotMatchesLineSeparators;
    }
    
    NSError *error=nil;
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:&error];
    if (error) {
        PYLog(@"Error creating Regex: %@",[error description]);
        return NO;  //Can't possibly match an invalid Regex
    }
    
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])] > 0);
}

-(BOOL)mdh_matchesPatternRegexPattern:(NSString *)regex {
    return [self mdh_matchesPatternRegexPattern:regex
                            caseInsensitive:NO
                             treatAsOneLine:NO];
}

@end
