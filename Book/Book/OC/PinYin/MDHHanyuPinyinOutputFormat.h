
#import <Foundation/Foundation.h>

/**
 *	Created by kimziv on 13-9-14.
 */
#ifndef _MDHHanyuPinyinOutputFormat_H_
#define _MDHHanyuPinyinOutputFormat_H_

typedef enum {
  ToneTypeWithToneNumber,
  ToneTypeWithoutTone,
  ToneTypeWithToneMark
}ToneType;

typedef enum {
    CaseTypeUppercase,
    CaseTypeLowercase
}CaseType;

typedef enum {
    VCharTypeWithUAndColon,
    VCharTypeWithV,
    VCharTypeWithUUnicode
}VCharType;


@interface MDHHanyuPinyinOutputFormat : NSObject

@property(nonatomic, assign) VCharType vCharType;
@property(nonatomic, assign) CaseType caseType;
@property(nonatomic, assign) ToneType toneType;

- (id)init;
- (void)restoreDefault;
@end

#endif // _MDHHanyuPinyinOutputFormat_H_
