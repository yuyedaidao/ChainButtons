//
//  ViewController.m
//  ChainButtons
//
//  Created by Wang on 15/6/3.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "ViewController.h"
#import "ChainButtons.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showButtons:(id)sender {
    
    [ChainButtons showWithImageNameArray:@[@"a",@"b",@"c",@"d"] clickBlock:^(NSInteger index) {
        NSLog(@"clicked %d",index);
    } bottomPosition:self.view.center];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
