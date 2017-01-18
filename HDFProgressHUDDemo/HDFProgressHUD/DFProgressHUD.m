//
//  DFProgressHUD.m
//  QDBN
//
//  Created by 胡定锋Mac on 15/8/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "DFProgressHUD.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@implementation DFProgressHUD

static MBProgressHUD *HUD;
static MBProgressHUD *nonBlockingHUD;
static NSString *prev_msg;
//MBProgressHUD 的使用方式，只对外两个方法，可以随时使用(但会有警告！)，其中窗口的 alpha 值 可以在源程序里修改。
+ (void)showHUD:(NSString *)msg{
    if( [prev_msg isEqualToString:msg] )
        return;
    [DFProgressHUD removeHUD];
    if( [UIApplication sharedApplication].keyWindow) {
        HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
        [[UIApplication sharedApplication].keyWindow addSubview:HUD];
        HUD.dimBackground = NO;
        HUD.labelText = msg;
        HUD.minSize = CGSizeMake(40, 40);
        HUD.labelFont = [UIFont boldSystemFontOfSize:13];
        HUD.mode = MBProgressHUDModeCustomView;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01"]];
        imgView.bounds = CGRectMake(0, 0, 30, 30);
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anima.toValue = @(M_PI*2);
        anima.duration = 1.0f;
        anima.repeatCount = 12;
        [imgView.layer addAnimation:anima forKey:nil];
        HUD.customView = imgView;
        
        [HUD show:YES];
        [HUD setRemoveFromSuperViewOnHide:YES];
        prev_msg = msg;
    }
}
+ (void)removeHUD{
    if( HUD )
    {
        [HUD hide:YES];
        HUD = nil;
        prev_msg = @"";
    }
}
+ (void)toastMessage:(NSDictionary*)dict{
    [self toastMessage:dict window:[UIApplication sharedApplication].keyWindow];
}
+ (void)toastMessage:(NSDictionary*)dict window:(UIWindow*)window{
    if( [dict.allKeys containsObject:@"message"] && [dict[@"message"] isKindOfClass:[NSString class]] )
        [DFProgressHUD showNonBlockingHUD:[NSString stringWithFormat:@"%@",dict[@"message"]]
                                addto:window
                    hideWithinSeconds:1.0f];
}

+ (void)showNonBlockingHUD:(NSString *)msg addto:(UIView*)superview hideWithinSeconds:(NSTimeInterval)delay{
    [DFProgressHUD removeNonBlockingHUD];
    nonBlockingHUD = [MBProgressHUD showHUDAddedTo:superview animated:YES];
    nonBlockingHUD.mode = MBProgressHUDModeText;
    nonBlockingHUD.color = [UIColor blackColor];
    //[UIColor colorWithHue:0.53 saturation:0.17 brightness:0.42 alpha:1];
    //[UIColor colorWithRed:0.87 green:0.43 blue:0.42 alpha:0.9];
    nonBlockingHUD.userInteractionEnabled = NO;
    nonBlockingHUD.labelFont = [UIFont boldSystemFontOfSize:15];

    nonBlockingHUD.detailsLabelColor = [UIColor whiteColor];
    nonBlockingHUD.detailsLabelText = msg;
    [nonBlockingHUD hide:YES afterDelay:delay];
}
+ (void)removeNonBlockingHUD{
    if( nonBlockingHUD )
    {
        [nonBlockingHUD hide:YES];
        nonBlockingHUD = nil;
    }
}

+ (UIColor *)defaultEnableColor{
    static UIColor *enableColor = nil;
    if( enableColor == nil )
        enableColor = [UIColor colorWithRed:0x2D/255.0 green:0xAD/255.0 blue:0xA1/255.0 alpha:1.0];
    return enableColor;
}
@end
