//
//  ViewController.m
//  HDFProgressHUDDemo
//
//  Created by 胡定锋Mac on 2017/1/18.
//  Copyright © 2017年 胡定锋. All rights reserved.
//

#import "ViewController.h"
#import "DFProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *onceAgain =[UIButton buttonWithType:UIButtonTypeCustom];
    onceAgain.frame = CGRectMake((self.view.frame.size.width-80)/2, self.view.frame.size.height-150, 80, 80);
    onceAgain.layer.cornerRadius = 40.f;
    [onceAgain setTitle:@"再来" forState:UIControlStateNormal];
    [onceAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onceAgain setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:onceAgain];
    [onceAgain addTarget:self action:@selector(onceagain) forControlEvents:UIControlEventTouchUpInside];
    [self run];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}
-(void)onceagain
{
    [self run];
}

-(void)run{
    [DFProgressHUD showHUD:@"加载中.."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DFProgressHUD removeHUD];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
