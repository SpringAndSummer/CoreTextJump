//
//  CoreTextView.h
//  CoreTextJump
//
//  Created by Spring on 2017/5/27.
//  Copyright © 2017年 Spring. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CoreTextViewBlock)();
@interface CoreTextView : UIView
@property (nonatomic, copy) CoreTextViewBlock coreTextViewBlock;//点击响应的回调

//设置富文本的内容,点击响应范围,字体大小
//text:显示的文本内容
//touchRange:响应点击的范围
//fontSize:字体的大小
- (void)setText:(NSString *)text touchRange:(NSRange)touchRange fontSize:(CGFloat)fontSize;

//生成富文本
//text:字符串对象
//range:点击范围
//fontSize:文字大小
+ (NSAttributedString *)attributedStringWithText:(NSString *)text andTouchRange:(NSRange)range fontSize:(CGFloat)fontSize;
@end
