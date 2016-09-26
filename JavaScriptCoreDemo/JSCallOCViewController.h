//
//  JSCallOCViewController.h
//  JavaScriptCoreDemo
//
//  Created by reborn on 16/9/12.
//  Copyright © 2016年 reborn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjectDelegate <JSExport>

- (void)callme:(NSString *)string;
- (void)share:(NSString *)shareUrl;
@end

@interface JSCallOCViewController : UIViewController

@end
