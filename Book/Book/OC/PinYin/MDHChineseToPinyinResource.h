//
//  
//
//  Created by kimziv on 13-9-14.
//

#import <Foundation/Foundation.h>

#ifndef _MDHChineseToPinyinResource_H_
#define _MDHChineseToPinyinResource_H_

@class NSArray;
@class NSMutableDictionary;

@interface MDHChineseToPinyinResource : NSObject {
    NSString* _directory;
    NSDictionary *_unicodeToHanyuPinyinTable;
}

- (id)init;
- (void)initializeResource;
- (NSArray *)getHanyuPinyinStringArrayWithChar:(unichar)ch;
- (BOOL)isValidRecordWithNSString:(NSString *)record;
- (NSString *)getHanyuPinyinRecordFromCharWithChar:(unichar)ch;
+ (MDHChineseToPinyinResource *)getInstance;

@end



#endif // _MDHChineseToPinyinResource_H_
