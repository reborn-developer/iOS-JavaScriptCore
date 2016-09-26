//
//  OCCallJSViewController.m
//  JavaScriptCoreDemo
//
//  Created by reborn on 16/9/12.
//  Copyright © 2016年 reborn. All rights reserved.
//

#import "OCCallJSViewController.h"

@interface OCCallJSViewController ()
{
    UITextField *textField;
    UILabel     *resultL;
}
@end

@implementation OCCallJSViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"oc call js";
    self.view.backgroundColor = [UIColor grayColor];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 250, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    UIButton *caculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    caculateBtn.frame = CGRectMake(50, 180, 140, 30);
    caculateBtn.backgroundColor = [UIColor blueColor];
    [caculateBtn setTitle:@"调用js方法计算" forState:UIControlStateNormal];
    [caculateBtn addTarget:self action:@selector(caculateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:caculateBtn];
    
    resultL = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 80, 30)];
    resultL.font = [UIFont systemFontOfSize:14];
    resultL.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:resultL];
    
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:[self loadJsFile:@"test"]];
}

- (NSString *)loadJsFile:(NSString*)fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"js"];
    NSString *jsScript = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return jsScript;
}

- (void)caculateButtonAction:(id)sender
{
    NSNumber *inputNumber = [NSNumber numberWithInteger:[textField.text integerValue]];
    JSValue *function = [self.context objectForKeyedSubscript:@"factorial"];
    JSValue *result = [function callWithArguments:@[inputNumber]];
    
    resultL.text = [NSString stringWithFormat:@"%@",[result toNumber]];
}

@end
