//
//  ViewController.m
//  JavaScriptCoreDemo
//
//  Created by reborn on 16/9/12.
//  Copyright © 2016年 reborn. All rights reserved.
//

#import "ViewController.h"
#import "JSCallOCViewController.h"
#import "OCCallJSViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 200, 30);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"JSCallOCButton" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jsCallOcButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    secondButton.frame = CGRectMake(50, 150, 200, 30);
    secondButton.backgroundColor = [UIColor cyanColor];
    [secondButton setTitle:@"OCCallJSButton" forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(oCCallJsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];
}

- (void)jsCallOcButtonAction:(id)sender
{
    JSCallOCViewController *jSCallOCViewController = [[JSCallOCViewController alloc] init];
    [self.navigationController pushViewController:jSCallOCViewController animated:YES];
}

- (void)oCCallJsButtonAction:(id)sender
{
    OCCallJSViewController *oCCallJSViewController = [[OCCallJSViewController alloc] init];
    [self.navigationController pushViewController:oCCallJSViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
