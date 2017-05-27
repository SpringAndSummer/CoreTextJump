//
//  ViewController.m
//  CoreTextJump
//
//  Created by Spring on 2017/5/27.
//  Copyright © 2017年 Spring. All rights reserved.
//

#import "ViewController.h"
#import "CoreTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor brownColor];
    
    NSString *content = @"温馨提示：未注册猫眼物联账号的手机号，登录时将自动注册，且代表您同意《猫眼物联用户协议》";
    CoreTextView *coreTextView1 = [[CoreTextView alloc] init];
    coreTextView1.backgroundColor = [UIColor yellowColor];
    CGFloat maxWidth = self.view.frame.size.width - 60;
    
    NSAttributedString *mus = [CoreTextView attributedStringWithText:content andTouchRange:NSMakeRange(34, 10) fontSize:14];
    CGSize size = [mus boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [coreTextView1 setText:content touchRange:NSMakeRange(34, 10) fontSize:14];
    coreTextView1.frame = CGRectMake(30, 100, maxWidth, size.height);
    [self.view addSubview:coreTextView1];
    
    CoreTextView *coreTextView2 = [[CoreTextView alloc] init];
    coreTextView2.backgroundColor = [UIColor yellowColor];
    CGFloat maxWidth2 = self.view.frame.size.width - 80;
    CGSize size2 = [mus boundingRectWithSize:CGSizeMake(maxWidth2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    [coreTextView2 setText:content touchRange:NSMakeRange(34, 10) fontSize:14];
    coreTextView2.frame = CGRectMake(30, 300, maxWidth2, size2.height);
    [self.view addSubview:coreTextView2];
}

@end
