//
//  JSCallOCViewController.m
//  JavaScriptCoreDemo
//
//  Created by reborn on 16/9/12.
//  Copyright © 2016年 reborn. All rights reserved.
//

#import "JSCallOCViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height

@interface JSCallOCViewController ()<UIWebViewDelegate, JSObjectDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) JSContext *context;
@end

@implementation JSCallOCViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"js call oc";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.webView];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JavaScriptCore" ofType:@"html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取html title设置导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //捕捉异常回调
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息: %@",exceptionValue);
    };
    
    //通过JSExport协议关联Native的方法
    self.context[@"Native"] = self;
    
    //通过block形式关联JavaScript中的函数
    __weak typeof(self) weakSelf = self;
    
    self.context[@"deliverValue"] = ^(NSString *message) {
        
        __strong typeof(self) strongSelf = weakSelf;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"this is a message" message:message preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertControl addAction:cancelAction];
            [strongSelf.navigationController presentViewController:alertControl animated:YES completion:nil];
        });
        
        
    };
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error == %@",error);
}

#pragma mark - JSExport Methods
- (void)callme:(NSString *)string
{
    NSLog(@"%@",string);
}

- (void)share:(NSString *)shareUrl
{
    NSLog(@"分享的url=%@",shareUrl);
    JSValue *shareCallBack = self.context[@"shareCallBack"];
    [shareCallBack callWithArguments:nil];
}

@end
