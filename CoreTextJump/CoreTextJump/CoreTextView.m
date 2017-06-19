//
//  CoreTextView.m
//  CoreTextJump
//
//  Created by Spring on 2017/5/27.
//  Copyright © 2017年 Spring. All rights reserved.
//

#import "CoreTextView.h"
@interface CoreTextView()
@property (nonatomic, strong) UITextView *textView;//显示富文本的控件
@property (nonatomic, assign) NSRange range;       //可以点击的文字范围
@end
@implementation CoreTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.textView = [[UITextView alloc]init];
        self.textView.editable = NO;// 不能编辑
        self.textView.scrollEnabled = NO;// 不能滚动
        self.textView.userInteractionEnabled = NO;// 不能交互
        self.textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);//设置文字的内边距(UITextView 本身内容存在向右偏移,大约5px,所以这里一定要设置偏移过来,否则,会出现只显示单行的问题)
        self.textView.backgroundColor = [UIColor clearColor];//背景透明
        [self addSubview:self.textView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
}

- (void)setText:(NSString *)text touchRange:(NSRange)touchRange fontSize:(CGFloat)fontSize
{
    self.range = touchRange;//记录点击范围
    self.textView.attributedText = [CoreTextView attributedStringWithText:text andTouchRange:touchRange fontSize:fontSize];
}

+ (NSAttributedString *)attributedStringWithText:(NSString *)text andTouchRange:(NSRange)range fontSize:(CGFloat)fontSize
{
    //显示富文本,这部分是生成富文本操作,根据不同的UI,需要去生成对应的富文本
    NSMutableAttributedString *atrs = [[NSMutableAttributedString alloc]initWithString:text];
    [atrs addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, atrs.length)];
    [atrs addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:range];
    [atrs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [atrs addAttribute:NSStrokeColorAttributeName value:[UIColor redColor] range:range];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];//设置行间距
    [atrs addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, atrs.length)];
    [atrs addAttribute:NSUnderlineStyleAttributeName value:@1 range:range];
    [atrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, atrs.length)];
    return atrs;
}

//重写touchesBegan:withEvent:方法,判断点击的焦点是否在文字设置的文字范围内
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.textView.selectedRange = self.range;
    
    // 算出选中的字符范围的边框,(由于可能换行,故会出现很多段)
    NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
    
    // 处理矩形框,首先去掉宽或者高为0的段
    NSMutableArray *rects = [NSMutableArray array];
    
    for (UITextSelectionRect *selectionRect in selectionRects)
    {
        if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
        [rects addObject:selectionRect];
        
    }
    
    //获取触摸点的位置
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    //遍历所有的选中范围,看触摸点是否其中,只要触摸点在范围中的一个就命中了
    BOOL selected = NO;
    for (UITextSelectionRect *selectionRect in rects)
    {
        // point 是否在rect范围内
        if (CGRectContainsPoint(selectionRect.rect, point))
        {
            selected = YES;
            break;
        }
    }
    //根据是否命中结果,来执行是否跳转操作
    if(selected)
    {
        NSLog(@"点中了,进行跳转");
        if(self.coreTextViewBlock)
        {
            self.coreTextViewBlock();
        }
    }
    else
    {
        NSLog(@"没有点中不跳转");
    }
}
@end
