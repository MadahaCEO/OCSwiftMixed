//
//
//
//  Created by kimziv on 13-9-14.
//

#include "MDHChineseToPinyinResource.h"
#include "MDHHanyuPinyinOutputFormat.h"
#include "MDHPinyinFormatter.h"
#include "MDHPinyinHelper.h"

#define HANYU_PINYIN @"Hanyu"
#define WADEGILES_PINYIN @"Wade"
#define MPS2_PINYIN @"MPSII"
#define YALE_PINYIN @"Yale"
#define TONGYONG_PINYIN @"Tongyong"
#define GWOYEU_ROMATZYH @"Gwoyeu"



@implementation MDHPinyinHelper

//////async methods
+ (void)toHanyuPinyinStringArrayWithChar:(unichar)ch
                                  outputBlock:(OutputArrayBlock)outputBlock
{
       [MDHPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch outputBlock:outputBlock];
}

+ (void)toHanyuPinyinStringArrayWithChar:(unichar)ch
                  withMDHHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat
                                  outputBlock:(OutputArrayBlock)outputBlock
{
   return [MDHPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withMDHHanyuPinyinOutputFormat:outputFormat outputBlock:outputBlock];
}

+ (void)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                            withMDHHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat
                                            outputBlock:(OutputArrayBlock)outputBlock
{
    [MDHPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch outputBlock:^(NSArray *array) {
        if (outputBlock) {
            if (nil != array) {
                NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:array.count];
                for (int i = 0; i < (int) [array count]; i++) {
                    [targetPinyinStringArray replaceObjectAtIndex:i withObject:[MDHPinyinFormatter formatHanyuPinyinWithNSString:
                                                                       [array objectAtIndex:i]withHanyuPinyinOutputFormat:outputFormat]];
                }
                outputBlock(targetPinyinStringArray);
            }
            else{
                outputBlock(nil);
            }
        }
    }];
}

+ (void)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch
                                              outputBlock:(OutputArrayBlock)outputBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       NSArray *array= [[MDHChineseToPinyinResource getInstance] getHanyuPinyinStringArrayWithChar:ch];
       dispatch_async(dispatch_get_main_queue(), ^{
            if (outputBlock) {
                outputBlock(array);
            }
        });
    });
}

+ (void)toTongyongPinyinStringArrayWithChar:(unichar)ch
                                     outputBlock:(OutputArrayBlock)outputBlock
{
     return [MDHPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: TONGYONG_PINYIN outputBlock:outputBlock];
}

+ (void)toWadeGilesPinyinStringArrayWithChar:(unichar)ch
                                      outputBlock:(OutputArrayBlock)outputBlock
{
    [MDHPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: WADEGILES_PINYIN outputBlock:outputBlock];
}

+ (void)toMPS2PinyinStringArrayWithChar:(unichar)ch
                                 outputBlock:(OutputArrayBlock)outputBlock
{
     [MDHPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: MPS2_PINYIN outputBlock:outputBlock];
}

+ (void)toYalePinyinStringArrayWithChar:(unichar)ch
                                 outputBlock:(OutputArrayBlock)outputBlock
{
    [MDHPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: YALE_PINYIN outputBlock:outputBlock];
}

+ (void)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                           withPinyinRomanizationType:(NSString *)targetPinyinSystem
                                          outputBlock:(OutputArrayBlock)outputBlock
{
    
     [MDHPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch outputBlock:^(NSArray *array) {
         if (outputBlock) {
             if (nil != array) {
                 NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:array.count];
                 for (int i = 0; i < (int) [array count]; i++) {
                    ///to do
                 }
                 outputBlock(targetPinyinStringArray);
             }
             else{
                 outputBlock(nil);
             }
         }
     }];
}
+ (void)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch
                                     outputBlock:(OutputArrayBlock)outputBlock
{
    
    [MDHPinyinHelper convertToGwoyeuRomatzyhStringArrayWithChar:ch outputBlock:outputBlock];
}

+ (void)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch
                                            outputBlock:(OutputArrayBlock)outputBlock
{
    [MDHPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch outputBlock:^(NSArray *array) {
        if (outputBlock) {
            if (nil != array) {
                NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:array.count];
                for (int i = 0; i < (int) [array count]; i++) {
                    ///to do
                }
                outputBlock(targetPinyinStringArray);
            }
            else{
                outputBlock(nil);
            }
        }
    }];
 
}

+ (void)toHanyuPinyinStringWithNSString:(NSString *)str
            withMDHHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat
                           withNSString:(NSString *)seperater
                            outputBlock:(OutputStringBlock)outputBlock
{
 //   __block NSMutableString *resultPinyinStrBuf = [[NSMutableString alloc] init];
//    for (int i = 0; i <  str.length; i++) {
//         [MDHPinyinHelper getFirstHanyuPinyinStringWithChar:[str characterAtIndex:i] withMDHHanyuPinyinOutputFormat:outputFormat outputBlock:^(NSString *pinYin) {
//             if (nil != pinYin) {
//                 [resultPinyinStrBuf appendString:pinYin];
//                 if (i != [str length] - 1) {
//                     [resultPinyinStrBuf appendString:seperater];
//                 }
//             }
//             else {
//                 [resultPinyinStrBuf appendFormat:@"%C",[str characterAtIndex:i]];
//             }
//             if (outputBlock) {
//                 outputBlock(resultPinyinStrBuf);
//             }
//
//         }];
//    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block NSMutableString *resultPinyinStrBuf = [[NSMutableString alloc] init];
        for (int i = 0; i <  str.length; i++) {
            NSString *mainPinyinStrOfChar = [MDHPinyinHelper getFirstHanyuPinyinStringWithChar:[str characterAtIndex:i] withMDHHanyuPinyinOutputFormat:outputFormat];
            if (nil != mainPinyinStrOfChar) {
                [resultPinyinStrBuf appendString:mainPinyinStrOfChar];
                if (i != [str length] - 1) {
                    [resultPinyinStrBuf appendString:seperater];
                }
            }
            else {
                [resultPinyinStrBuf appendFormat:@"%C",[str characterAtIndex:i]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (outputBlock) {
                outputBlock(resultPinyinStrBuf);
            }
        });
    });
}

+ (void)getFirstHanyuPinyinStringWithChar:(unichar)ch
                    withMDHHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat
                                    outputBlock:(OutputStringBlock)outputBlock
{
    [self getFormattedHanyuPinyinStringArrayWithChar:ch withMDHHanyuPinyinOutputFormat:outputFormat outputBlock:^(NSArray *array) {
        if (outputBlock) {
            if ((nil != array) && ((int) [array count] > 0)) {
                outputBlock([array objectAtIndex:0]);
            }else {
               outputBlock(nil);
            }
            
        }
    }];
}

/////sync methods

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch {
    return [MDHPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
}

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch
                  withMDHHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat {
    return [MDHPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withMDHHanyuPinyinOutputFormat:outputFormat];
}

+ (NSArray *)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                            withMDHHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat {
    NSMutableArray *pinyinStrArray =[NSMutableArray arrayWithArray:[MDHPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch]];
    if (nil != pinyinStrArray) {
        for (int i = 0; i < (int) [pinyinStrArray count]; i++) {
            [pinyinStrArray replaceObjectAtIndex:i withObject:[MDHPinyinFormatter formatHanyuPinyinWithNSString:
                                                               [pinyinStrArray objectAtIndex:i]withHanyuPinyinOutputFormat:outputFormat]];
        }
        return pinyinStrArray;
    }
    else return nil;
}

+ (NSArray *)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch {
    return [[MDHChineseToPinyinResource getInstance] getHanyuPinyinStringArrayWithChar:ch];
}

+ (NSArray *)toTongyongPinyinStringArrayWithChar:(unichar)ch {
    return [MDHPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: TONGYONG_PINYIN];
}

+ (NSArray *)toWadeGilesPinyinStringArrayWithChar:(unichar)ch {
    return [MDHPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: WADEGILES_PINYIN];
}

+ (NSArray *)toMPS2PinyinStringArrayWithChar:(unichar)ch {
    return [MDHPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: MPS2_PINYIN];
}

+ (NSArray *)toYalePinyinStringArrayWithChar:(unichar)ch {
    return [MDHPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: YALE_PINYIN];
}

+ (NSArray *)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                           withPinyinRomanizationType:(NSString *)targetPinyinSystem {
    NSArray *hanyuPinyinStringArray = [MDHPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
    if (nil != hanyuPinyinStringArray) {
        NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:hanyuPinyinStringArray.count];
        for (int i = 0; i < (int) [hanyuPinyinStringArray count]; i++) {
            
        }
        return targetPinyinStringArray;
    }
    else return nil;
}

+ (NSArray *)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch {
    return [MDHPinyinHelper convertToGwoyeuRomatzyhStringArrayWithChar:ch];
}

+ (NSArray *)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch {
    NSArray *hanyuPinyinStringArray = [MDHPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
    if (nil != hanyuPinyinStringArray) {
        NSMutableArray *targetPinyinStringArray =[NSMutableArray arrayWithCapacity:hanyuPinyinStringArray.count];
        for (int i = 0; i < (int) [hanyuPinyinStringArray count]; i++) {
        }
        return targetPinyinStringArray;
    }
    else return nil;
}

+ (NSString *)toHanyuPinyinStringWithNSString:(NSString *)str
                  withMDHHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat
                                 withNSString:(NSString *)seperater {
    NSMutableString *resultPinyinStrBuf = [[NSMutableString alloc] init];
    for (int i = 0; i <  str.length; i++) {
        NSString *mainPinyinStrOfChar = [MDHPinyinHelper getFirstHanyuPinyinStringWithChar:[str characterAtIndex:i] withMDHHanyuPinyinOutputFormat:outputFormat];
        if (nil != mainPinyinStrOfChar) {
            [resultPinyinStrBuf appendString:mainPinyinStrOfChar];
            if (i != [str length] - 1) {
                [resultPinyinStrBuf appendString:seperater];
            }
        }
        else {
            [resultPinyinStrBuf appendFormat:@"%C",[str characterAtIndex:i]];
        }
    }
    return resultPinyinStrBuf;
}

+ (NSString *)getFirstHanyuPinyinStringWithChar:(unichar)ch
                    withMDHHanyuPinyinOutputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat {
    NSArray *pinyinStrArray = [MDHPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withMDHHanyuPinyinOutputFormat:outputFormat];
    if ((nil != pinyinStrArray) && ((int) [pinyinStrArray count] > 0)) {
        return [pinyinStrArray objectAtIndex:0];
    }
    else {
        return nil;
    }
}


#pragma mark - 扩展多音字
+ (NSArray *)getPinyinWithHanzi:(NSString *)str
                   outputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat
                seperaterString:(NSString *)seperater {

    NSMutableArray *dataSource = [NSMutableArray array];

    for (int i = 0; i <  str.length; i++) {
       
        NSArray *array = [MDHPinyinHelper getPinyinWithCharactor:[str characterAtIndex:i] outputFormat:outputFormat];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSString *string in array) {
            
            if (![tempArray containsObject:string]) {
                [tempArray addObject:string];
            }
        }
        
        [dataSource addObject:tempArray];
    }

    return dataSource;
}


+ (NSArray *)getPinyinWithCharactor:(unichar)ch
                       outputFormat:(MDHHanyuPinyinOutputFormat *)outputFormat {
    NSArray *pinyinStrArray = [MDHPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withMDHHanyuPinyinOutputFormat:outputFormat];
    if (pinyinStrArray && pinyinStrArray.count > 0) {
        
        return pinyinStrArray;
    }
    
    return @[];   
}



@end
