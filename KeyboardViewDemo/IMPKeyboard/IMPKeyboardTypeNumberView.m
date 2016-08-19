//
//  IMPKeyboardTypeNumberView.m
//  customKeyboard
//
//  Created by ligui on 15/9/16.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import "IMPKeyboardTypeNumberView.h"
#import "UIView+Extension.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface IMPKeyboardTypeNumberView ()
{
    UIImageView *deleteImageView;
    UIImageView *symbolImageView;
    
}
/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;

/** 符号按钮 */
@property (nonatomic, strong) UIButton *symbolBtn;

/** ABC 文字按钮 */
@property (nonatomic, strong) UIButton *textBtn;

/** 确定按钮 */
@property (nonatomic, strong) UIButton *confirmBtn;

/** 小数点按钮 */
@property (nonatomic, strong) UIButton *dotBtn;

/** 是否密码输入 */
@property (nonatomic, assign) BOOL isSecretKeyboard;

@end
@implementation IMPKeyboardTypeNumberView

- (instancetype)initWithFrame:(CGRect)frame isSecretKeyboard:(BOOL)isSecretKeyboard
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=UIColorFromRGB(0xdad9d8);
        self.isSecretKeyboard = isSecretKeyboard;
        self.userInteractionEnabled = YES;
        [self createNumberView];
    }
    return self;
}
- (void)createNumberView
{
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    if (self.isSecretKeyboard) {
        for (int i = 0 ; i < 10; i++) {
            int j = arc4random_uniform(10);
            
            NSNumber *number = [[NSNumber alloc] initWithInt:j];
            if ([arrM containsObject:number]) {
                i--;
                continue;
            }
            [arrM addObject:number];
        }
    }else{
        for (int i = 0 ; i < 10; i++) {
            NSNumber *number = [[NSNumber alloc] initWithInt:i];
            [arrM addObject:number];
        }
    }
    NSLog(@"arrM========%@",arrM);
    for (int i = 0; i < 10; i++) {
        
        UIButton *numBtn = [[UIButton alloc] init];
        NSNumber *number = arrM[i];
        NSString *title = number.stringValue;
        [numBtn setBackgroundColor:UIColorFromRGB(0xf4f5f4)];
        [numBtn setTitle:title forState:UIControlStateNormal];
        numBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:numBtn];
    }
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setBackgroundColor:UIColorFromRGB(0xf4f5f4)];
    self.deleteBtn.userInteractionEnabled = YES;
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    deleteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"keyboard_del"]];
    deleteImageView.userInteractionEnabled = NO;
    [self.deleteBtn addSubview:deleteImageView];
    
    [self addSubview:self.deleteBtn];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.confirmBtn setBackgroundColor:UIColorFromRGB(0x66adfb)];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.confirmBtn];
    
    
        self.symbolBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.symbolBtn setBackgroundColor:UIColorFromRGB(0xf4f5f4)];
        self.symbolBtn.userInteractionEnabled = YES;
    if (self.isSecretKeyboard) {
        
    }else{
        [self.symbolBtn addTarget:self action:@selector(symbolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        symbolImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"keyboard_keyboard"]];
    }
        symbolImageView.userInteractionEnabled = NO;
        [self.symbolBtn addSubview:symbolImageView];
        [self addSubview:self.symbolBtn];
    
    self.dotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dotBtn setBackgroundColor:UIColorFromRGB(0xf4f5f4)];
    [self.dotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.dotBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    if (!self.isSecretKeyboard) {
        [self.dotBtn setTitle:@"." forState:UIControlStateNormal];
        [self.dotBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:self.dotBtn];
}
- (void)layoutSubviews {
    
    CGFloat topBtnW = (self.width - 1.5) / 4;
    CGFloat topBtnH = (self.height - 1.5) / 4;
    
    NSUInteger count = self.subviews.count;
    
    // 布局数字按钮
    for (NSUInteger i = 0; i < count; i++) {
        if (i == 0 ) { // 0
            UIButton *buttonZero = self.subviews[i];
            buttonZero.height = topBtnH;
            buttonZero.width = topBtnW;
            buttonZero.x = topBtnW+0.5;
            buttonZero.y = self.bounds.size.height-topBtnH;
            
            // 符号、文字及删除按钮的位置
            
            self.deleteBtn.x = (topBtnW)*3+1.5;
            self.deleteBtn.y = 0;
            self.deleteBtn.width = buttonZero.width;
            self.deleteBtn.height = buttonZero.height*2;
            
            deleteImageView.frame = CGRectMake(topBtnW/2-15, topBtnH-15, 30, 30);
            
            self.confirmBtn.frame = CGRectMake(self.deleteBtn.x, self.deleteBtn.y+self.deleteBtn.height, topBtnW, 2*topBtnH+1);
            
            self.symbolBtn.frame=CGRectMake(2*topBtnW+1, buttonZero.y, topBtnW,topBtnH);
            
            symbolImageView.frame = CGRectMake(topBtnW/2-topBtnH/4, topBtnH/4, topBtnH/2, topBtnH/2);
            
            self.dotBtn.frame = CGRectMake(0, buttonZero.y, topBtnW, topBtnH);
            
            
        }
        if (i > 0 && i < 10) { // 0 ~ 9
            
            UIButton *topButton = self.subviews[i];
            CGFloat row = (i - 1) / 3;
            CGFloat col = (i - 1) % 3;

            topButton.x = col * (topBtnW + 0.5);
            topButton.y = row * (topBtnH + 0.5);
            topButton.width = topBtnW;
            topButton.height = topBtnH;
        }
        
    }
}
- (void)symbolBtnClick:(UIButton *)symbolBtn {
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickSymbolBtn:)]) {
        [self.delegate keyboard:self didClickSymbolBtn:symbolBtn];
    }
}
- (void)confirmBtnClick:(UIButton *)confirmBtn {
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickConfirmBtn:)]) {
        [self.delegate keyboard:self didClickConfirmBtn:confirmBtn];
    }
}
- (void)numBtnClick:(UIButton *)numBtn {
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickButton:)]) {
        [self.delegate keyboard:self didClickButton:numBtn];
    }
}
- (void)deleteBtnClick:(UIButton *)deleteBtn{
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteBtn:)]) {
        [self.delegate keyboard:self didClickDeleteBtn:deleteBtn];
    }
}
@end
