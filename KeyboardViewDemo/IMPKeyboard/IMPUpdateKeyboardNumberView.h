//
//  IMPUpdateKeyboardNumberView.h
//  IMobPay
//
//  Created by ligui on 16/6/1.
//  Copyright © 2016年 QTPay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IMPUpdateKeyboardNumberView;
@protocol IMPUpdateKeyboardNumberViewDelegate <NSObject>
@optional
/** 点击了数字按钮 */
- (void)keyboard:(IMPUpdateKeyboardNumberView *)keyboard didClickButton:(UIButton *)button;
/** 点击删除按钮 */
- (void)keyboard:(IMPUpdateKeyboardNumberView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn;
/** 点击确定按钮 */
- (void)keyboard:(IMPUpdateKeyboardNumberView *)keyboard didClickConfirmBtn:(UIButton *)confirmBtn;
/** 点击符号按钮 */
- (void)keyboard:(IMPUpdateKeyboardNumberView *)keyboard didClickSymbolBtn:(UIButton *)symbolBtn;
@end
@interface IMPUpdateKeyboardNumberView : UIView
- (instancetype)initWithFrame:(CGRect)frame isSecretKeyboard:(BOOL)isSecretKeyboard;//定义样式是否为随机密码键盘
@property (nonatomic, weak) id<IMPUpdateKeyboardNumberViewDelegate> delegate;

@end
@interface IMPUpdateKeyboardNumberTipsView : UIView
- (void)addContentsToTipsView:(NSString *)addStr;
//- (void)deleteContentsToTipsView:(NSString *)deleteStr;
@end