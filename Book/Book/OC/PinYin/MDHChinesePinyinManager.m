//
//  MDHChinesePinyinManager.m
//  MDHFoundation
//
//  Created by Apple on 2017/8/31.
//  Copyright © 2017年 马大哈. All rights reserved.
//

#import "MDHChinesePinyinManager.h"
#import "MDHPinYin4Objc.h"
//#import "NSString+MDHFoundation.h"

@interface MDHChinesePinyinManager ()
{

    MDHHanyuPinyinOutputFormat *_outputFormat;
    NSMutableArray *_needResultArr;

}

@end





@implementation MDHChinesePinyinManager



- (instancetype)init {
    self = [super init];
    if (self) {
        
        _outputFormat = [[MDHHanyuPinyinOutputFormat alloc] init];
        [_outputFormat setToneType:ToneTypeWithoutTone];
        [_outputFormat setVCharType:VCharTypeWithV];
        [_outputFormat setCaseType:CaseTypeLowercase];
        
        _needResultArr = [NSMutableArray array];

    }
    
    return  self;
}

- (BOOL)regexCheck:(NSString *)string {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[\u4e00-\u9fa5]+$"];
    BOOL valid = [predicate evaluateWithObject: string];
    
    return valid;
}

- (NSArray *)firstLetters:(NSString *)string {

    NSMutableArray *dataSource = [NSMutableArray array];
    
    if ([string isKindOfClass:[NSString class]] &&
        string.length > 0 &&
        [self regexCheck:string]) {
        
        NSMutableArray* result = [NSMutableArray array];
        NSArray *array_data    = [MDHPinyinHelper getPinyinWithHanzi:string
                                                        outputFormat:_outputFormat
                                                     seperaterString:@","];
        
        [self combine:result data:array_data curr:0 count:(int)array_data.count];
        
        //    NSLog(@" \n%@ ",_needResultArr);
        
        for (NSArray *nameArray in _needResultArr) {
            
            //        NSLog(@"多音字 : %@", [nameArray componentsJoinedByString:@" "]);
            if (nameArray.count > 0) {
                NSString *firstWord = nameArray.firstObject;
                if (firstWord.length > 0) {
                    NSString *firstLetter = [[firstWord substringToIndex:1] uppercaseString];
                    if (![dataSource containsObject:firstLetter]) {
                        
                        [dataSource addObject:[[firstWord substringToIndex:1] uppercaseString]];
                    }
                }
            }
        }
    }
    
    return dataSource;
}

- (NSArray *)toPinyin:(NSString *)string {
    
    NSMutableArray *dataSource = [NSMutableArray array];
    
    if ([string isKindOfClass:[NSString class]] &&
        string.length > 0 &&
        [self regexCheck:string]) {
        
        NSMutableArray* result = [NSMutableArray array];
        NSArray *array_data    = [MDHPinyinHelper getPinyinWithHanzi:string
                                                        outputFormat:_outputFormat
                                                     seperaterString:@","];
        
        [self combine:result data:array_data curr:0 count:(int)array_data.count];
        
        //    NSLog(@" \n%@ ",_needResultArr);
        
        for (NSArray *nameArray in _needResultArr) {
            
            //        NSLog(@"多音字 : %@", [nameArray componentsJoinedByString:@" "]);
            [dataSource addObject:[nameArray componentsJoinedByString:@" "]];
        }
    }
    
    return dataSource;
}




- (void)combine:(NSMutableArray *)result data:(NSArray *)data curr:(int)currIndex count:(int)count {
    
    if (currIndex == count) {
        
        [_needResultArr addObject:[result mutableCopy]];
        [result removeLastObject];
        
    }else {
        NSArray* array = [data objectAtIndex:currIndex];
        
        for (int i = 0; i < array.count; ++i) {
            [result addObject:[array objectAtIndex:i]];
            //进入递归循环
            [self combine:result data:data curr:currIndex+1 count:count];
            
            if ((i+1 == array.count) && (currIndex-1>=0)) {
                [result removeObjectAtIndex:currIndex-1];
            }
        }
    }
}


@end
