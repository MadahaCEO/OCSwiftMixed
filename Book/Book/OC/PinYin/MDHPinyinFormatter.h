//
//  
//
//  Created by kimziv on 13-9-14.
//

#ifndef _PinyinFormatter_H_
#define _PinyinFormatter_H_

@class MDHHanyuPinyinOutputFormat;

@interface MDHPinyinFormatter : NSObject {
}

+ (NSString *)formatHanyuPinyinWithNSString:(NSString *)pinyinStr
                withHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat;
+ (NSString *)convertToneNumber2ToneMarkWithNSString:(NSString *)pinyinStr;
- (id)init;
@end

#endif // _PinyinFormatter_H_
