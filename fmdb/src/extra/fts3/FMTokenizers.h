//
//  FMTokenizers.h
//  fmdb
//
//  Created by Andrew on 4/9/14.
//  Copyright (c) 2014 Andrew Goodale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase+FTS3.h"

NS_ASSUME_NONNULL_BEGIN

/**
 This is the base tokenizer implementation, using a CFStringTokenizer to find words.
 */
@interface FMSimpleTokenizer : NSObject <FMTokenizerDelegate>

/**
 Create the tokenizer with a given locale. The locale will be used to initialize the string tokenizer and to lowercase the parsed word.


 @param locale The locale used by the simple tokenizer. The locale can be @c NULL , in which case the current locale will be used.
 */
- (instancetype)initWithLocale:(CFLocaleRef _Nullable)locale;

@end

#pragma mark

/**
 This tokenizer extends the simple tokenizer with support for a stop word list.
 */
@interface FMStopWordTokenizer : NSObject <FMTokenizerDelegate>

@property (atomic, copy) NSSet *words;

/**
 Load a stop-word tokenizer using a file containing words delimited by newlines. The file should be encoded in UTF-8.

 @param wordFileURL The file URL for the list of words.
 @param tokenizer The @c FMTokenizerDelegate .
 @param error The @c NSError if there was any error reading the file.
 */
+ (instancetype)tokenizerWithFileURL:(NSURL *)wordFileURL baseTokenizer:(id<FMTokenizerDelegate>)tokenizer error:(NSError * _Nullable *)error;

/**
 Initialize an instance of the tokenizer using the set of words. The words should be lowercase if you're using the
 `FMSimpleTokenizer` as the base.
 @param words The @c NSSet of words.
 @param tokenizer The @c FMTokenizerDelegate .
 */
- (instancetype)initWithWords:(NSSet *)words baseTokenizer:(id<FMTokenizerDelegate>)tokenizer;

@end

NS_ASSUME_NONNULL_END
