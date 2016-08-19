//
//  IMPKeyboardTypeNumberView.h
//  customKeyboard
//
//  Created by ligui on 15/9/16.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IMPKeyboardTypeNumberView;
@protocol IMPKeyboardTypeNumberViewDelegate <NSObject>
@optional
/** 点击了数字按钮 */
- (void)keyboard:(IMPKeyboardTypeNumberView *)keyboard didClickButton:(UIButton *)button;
/** 点击删除按钮 */
- (void)keyboard:(IMPKeyboardTypeNumberView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn;
/** 点击确定按钮 */
- (void)keyboard:(IMPKeyboardTypeNumberView *)keyboard didClickConfirmBtn:(UIButton *)confirmBtn;
/** 点击符号按钮 */
- (void)keyboard:(IMPKeyboardTypeNumberView *)keyboard didClickSymbolBtn:(UIButton *)symbolBtn;
@end
@interface IMPKeyboardTypeNumberView : UIView
- (instancetype)initWithFrame:(CGRect)frame isSecretKeyboard:(BOOL)isSecretKeyboard;//定义样式是否为随机密码键盘
@property (nonatomic, weak) id<IMPKeyboardTypeNumberViewDelegate> delegate;

@end
