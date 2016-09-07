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

@property (nonatomic, strong) UIButton *brn;
@property (nonatomic, strong) YBScrollView *scroller;

@end

@implementation YBMsgRootCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    YBScrollView *scroller = [[YBScrollView alloc] initWithFrame:CGRectZero];
    scroller.backgroundColor = [UIColor redColor];
    [self.view addSubview:scroller];
    self.scroller = scroller;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(100, 200, 200, 50);
    btn.exclusiveTouch = true;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(activeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    NSString *info = [NSString stringWithFormat:@"active:%zd",btn.isSelected];
    [btn setTitle:info forState:UIControlStateNormal];
}

- (void)activeBtnEvent:(UIButton *)btn {
    btn.selected = !btn.selected;
    NSString *info = [NSString stringWithFormat:@"active:%zd",btn.isSelected];
    [btn setTitle:info forState:UIControlStateNormal];
    [self.scroller activeConstraint:btn.isSelected];
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
