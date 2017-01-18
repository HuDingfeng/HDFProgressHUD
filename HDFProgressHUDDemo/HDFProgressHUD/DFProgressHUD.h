//
//  DFProgressHUD.h
//  QDBN
//
//  Created by 胡定锋Mac on 15/8/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MBProgressHUD.h"

@interface DFProgressHUD :NSObject
+ (void)showHUD:(NSString *)msg;
+ (void)removeHUD;

+ (void)showNonBlockingHUD:(NSString *)msg addto:(UIView*)superview hideWithinSeconds:(NSTimeInterval)delay;
+ (void)toastMessage:(NSDictionary*)dict;
+ (void)toastMessage:(NSDictionary*)dict window:(UIWindow*)window;

+ (UIColor *)defaultEnableColor;

@end
