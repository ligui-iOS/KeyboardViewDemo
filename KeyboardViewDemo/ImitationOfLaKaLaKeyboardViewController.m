//
//  ImitationOfLaKaLaKeyboardViewController.m
//  KeyboardViewDemo
//
//  Created by ligui on 16/6/2.
//  Copyright © 2016年 ligui. All rights reserved.
//

#import "ImitationOfLaKaLaKeyboardViewController.h"
#import "IMPImitationOfLaKaLaKeyboardView.h"

@interface ImitationOfLaKaLaKeyboardViewController ()<UITextFieldDelegate,IMPImitationOfLaKaLaKeyboardViewDelegate>
@property (strong, nonatomic) UITextField *textField;
@property (nonatomic, strong) NSMutableString *inputStr;
@property (nonatomic, strong) IMPImitationOfLaKaLaKeyboardView *impKeyboard;
@property (nonatomic, strong) IMPImitationOfLaKaLaKeyboardTipsView  *tipsView;
@end

@implementation ImitationOfLaKaLaKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 200, 220, 20)];
    _textField.placeholder = @"请输入短信验证码";
    [_textField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(60, 240, 200, 30);
    [btn setTitle:@"弹下" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)btnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -------------------UITextFieldDelegate----------------
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //    moneyTF.text = nil;
    if ([_textField.text isEqualToString:@""]) {
        NSUInteger loc = self.inputStr.length;
        NSRange range = NSMakeRange(0, loc);
        [self.inputStr deleteCharactersInRange:range];
    }
    CGFloat x = 0;
    CGFloat y = self.view.bounds.size.height - 216;
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = 216;
    
    self.impKeyboard = [[IMPImitationOfLaKaLaKeyboardView alloc] initWithFrame:CGRectMake(x, y, w, h) isSecretKeyboard:NO];
//    self.tipsView = [[IMPUpdateKeyboardNumberTipsView alloc] init];
//    self.tipsView.frame = CGRectMake(0, self.view.bounds.size.height - 216-35, self.view.bounds.size.width, 35);
    self.tipsView = [[IMPImitationOfLaKaLaKeyboardTipsView alloc] init];
    self.tipsView.frame = CGRectMake(0, self.view.bounds.size.height - 216-35, self.view.bounds.size.width, 35);
    self.impKeyboard.delegate = self;
    
    //    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    //    accessoryView.backgroundColor = UIColorFromRGB(0xdad9d8);
    _textField.inputView = self.impKeyboard;
    _textField.inputAccessoryView = self.tipsView;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    if ([_textField.text isEqualToString:@""]) {
    //        NSUInteger loc = self.inputStr.length;
    //        NSRange range = NSMakeRange(0, loc);
    //        [self.inputStr deleteCharactersInRange:range];
    //    }
    if (self.inputStr&&![self.inputStr isEqualToString:@""]) {
        [self.tipsView addContentsToTipsView:self.inputStr];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSUInteger loc = self.inputStr.length;
    NSRange range = NSMakeRange(0, loc);
    [self.inputStr deleteCharactersInRange:range];
    return YES;
}
#pragma mark -------------------IMPKeyboardTypeNumberViewDelegate----------------
/** 点击了数字按钮 */
- (void)keyboard:(IMPImitationOfLaKaLaKeyboardView *)keyboard didClickButton:(UIButton *)button
{
    NSString *numStr = button.currentTitle;
    if (self.inputStr.length>8) {
        return;
    }
    if (self.inputStr.length > 3) {
        if ([[self.inputStr substringWithRange:NSMakeRange(self.inputStr.length-3, 1)] isEqualToString:@"."]) {
            return;
        }
    }
    if (self.inputStr.length==1&&[numStr isEqualToString:@"."]) {
        self.inputStr = nil;
        _textField.text = nil;
    }
    [self.inputStr appendString:numStr];
    _textField.text = self.inputStr;
    NSLog(@"inputStr=====%@",self.inputStr);
    [self.tipsView addContentsToTipsView:self.inputStr];
}
/** 点击删除按钮 */
- (void)keyboard:(IMPImitationOfLaKaLaKeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn
{
    NSUInteger loc = self.inputStr.length;
    if (loc == 0)   return;
    NSRange range = NSMakeRange(loc - 1, 1);
    [self.inputStr deleteCharactersInRange:range];
    _textField.text = self.inputStr;
    NSLog(@"%@", _textField.text);
    [self.tipsView addContentsToTipsView:self.inputStr];
    
}
- (NSMutableString *)inputStr {
    if (!_inputStr) {
        _inputStr = [NSMutableString string];
    }
    return _inputStr;
}
/** 点击确定按钮 */
- (void)keyboard:(IMPImitationOfLaKaLaKeyboardView *)keyboard didClickConfirmBtn:(UIButton *)confirmBtn
{
    [_textField resignFirstResponder];
}
/** 点击符号按钮 */
- (void)keyboard:(IMPImitationOfLaKaLaKeyboardView *)keyboard didClickSymbolBtn:(UIButton *)symbolBtn
{
    [_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
