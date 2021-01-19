//
//  MDHChinesePinyinManager.h
//  MDHFoundation
//
//  Created by Apple on 2017/8/31.
//  Copyright © 2017年 马大哈. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDHChinesePinyinManager : NSObject

/**
 *  返回汉字首字母
 *
 *  @param string          目标汉字
 *
 *  @return 数组（多音字）
 
 ****************************************************
 汉字：贾
 array = @[
           @"J", // jia
           @"G", // gu
          ];

 */
- (NSArray *)firstLetters:(NSString *)string;


/**
 *  返回汉字拼音（全拼）一般用于姓名转拼音
 *
 *  @param string          目标汉字
 *
 *  @return 数组（多音字，且字符串以  空格  隔开）
 
 ****************************************************
 姓名：李长行
 array = @[
           @"li zhang xing",
           @"li zhang hang",
           @"li zhang heng",
           @"li chang xing",
           @"li chang hang",
           @"li chang heng"
          ];
 */
- (NSArray *)toPinyin:(NSString *)string;

@end
