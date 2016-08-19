//
//  IMPImitationOfLaKaLaKeyboardView.h
//  KeyboardViewDemo
//
//  Created by ligui on 16/6/2.
//  Copyright © 2016年 ligui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IMPImitationOfLaKaLaKeyboardView;
@protocol IMPImitationOfLaKaLaKeyboardViewDelegate <NSObject>
@optional
/** 点击了数字按钮 */
- (void)keyboard:(IMPImitationOfLaKaLaKeyboardView *)keyboard didClickButton:(UIButton *)button;
/** 点击删除按钮 */
- (void)keyboard:(IMPImitationOfLaKaLaKeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn;
/** 点击确定按钮 */
- (void)keyboard:(IMPImitationOfLaKaLaKeyboardView *)keyboard didClickConfirmBtn:(UIButton *)confirmBtn;
/** 点击符号按钮 */
- (void)keyboard:(IMPImitationOfLaKaLaKeyboardView *)keyboard didClickSymbolBtn:(UIButton *)symbolBtn;
@end
@interface IMPImitationOfLaKaLaKeyboardView : UIView
- (instancetype)initWithFrame:(CGRect)frame isSecretKeyboard:(BOOL)isSecretKeyboard;//定义样式是否为随机密码键盘
@property (nonatomic, weak) id<IMPImitationOfLaKaLaKeyboardViewDelegate> delegate;

@end
@interface IMPImitationOfLaKaLaKeyboardTipsView : UIView
- (void)addContentsToTipsView:(NSString *)addStr;
//- (void)deleteContentsToTipsView:(NSString *)deleteStr;
@end

