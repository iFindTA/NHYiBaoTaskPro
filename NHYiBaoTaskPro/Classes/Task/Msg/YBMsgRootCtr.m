//
//  YBMsgRootCtr.m
//  NHYiBaoTaskPro
//
//  Created by nanhu on 16/8/31.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import "YBMsgRootCtr.h"
#import "YBScrollView.h"

@interface YBMsgRootCtr ()

@end

@implementation YBMsgRootCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    YBScrollView *scroller = [[YBScrollView alloc] initWithFrame:CGRectZero];
    scroller.backgroundColor = [UIColor redColor];
    [self.view addSubview:scroller];
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
