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

@property (nonatomic, strong) UIView *contentView,*taskView,*recordView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, strong) MASConstraint *constraint;

@end

@implementation YBMsgRootCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    YBScrollView *scroller = [[YBScrollView alloc] initWithFrame:self.view.bounds];
    scroller.backgroundColor = [UIColor redColor];
    [self.view addSubview:scroller];
    self.scroller = scroller;
    [scroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    /*
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.backgroundColor = [UIColor pb_randomColor];
    [self.view addSubview:scroll];
    self.scrollView = scroll;
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    UIView *contaner = [[UIView alloc] initWithFrame:CGRectZero];
    contaner.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:contaner];
    _contentView = contaner;
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.width.equalTo(scroll);
    }];
    
    UIView *task = [[UIView alloc] init];
    task.backgroundColor = [UIColor pb_randomColor];
    [self.contentView addSubview:task];
    self.taskView = task;
    UIView *record = [[UIView alloc] init];
    record.backgroundColor = [UIColor pb_randomColor];
    //[self.contentView addSubview:record];
    self.recordView = record;
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor pb_randomColor];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = PBSCREEN_WIDTH;
    [self.contentView addSubview:label];
    self.descLabel = label;
    self.isActive = true;
    //其次布局内容
    weakify(self)
    [self.taskView mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@500);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.taskView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        //make.height.equalTo(@450).priority(UILayoutPriorityDefaultHigh);
        //self.constraint = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
    }];
//    if (self.isActive) {
//        [self.constraint activate];
//    }else{
//        [self.constraint deactivate];
//    }
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.descLabel.mas_bottom);
    }];
    //*/
    
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

static NSString *longString = @"相声（Crosstalk），一种民间说唱曲艺。相声一词，古作象生，原指模拟别人的言行，后发展为象声。象声又称隔壁象声。相声起源于华北地区的民间说唱曲艺，在明朝即已盛行。经清朝时期的发展直至民国初年，相声逐渐从一个人摹拟口技发展成为单口笑话，名称也就随之转变为相声。一种类型的单口相声，后来逐步发展为多种类型：单口相声、对口相声、群口相声，综合为一体。相声在两岸三地有不同的发展模式。中国相声有三大发源地：北京天桥、天津劝业场、三不管儿和南京夫子庙。相声艺术源于华北，流行于京津冀，普及于全国及海内外，始于明清，盛于当代。主要采用口头方式表演。表演形式有单口相声、对口相声、群口相声等，是扎根于民间、源于生活、又深受群众欢迎的曲艺表演艺术形式。相声鼻祖为张三禄，著名流派有“马（三立）派”、“侯（宝林）派”、“常（宝堃）派”、“苏（文茂）派”、“马（季）派”等。著名相声表演大师有马三立、侯宝林、常宝堃、苏文茂、刘宝瑞等多人。二十世纪晚期，以侯宝林、马三立为首的一代相声大师相继陨落，相声事业陷入低谷。2005年起，凭借在网络视频网站等新兴媒体的传播，相声演员郭德纲及其德云社异军突起，使公众重新关注相声这一艺术门类，实现了相声的二次复兴。";
static NSString *shortString = @"相声（Crosstalk），一种民间说唱曲艺。相声一词，古作象生，原指模拟别人的言行，后发展为象声。象声又称隔壁象声。相声起源于华北地区的民间说唱曲艺，在明朝即已盛行";

- (void)activeBtnEvent:(UIButton *)btn {
    btn.selected = !btn.selected;
    NSString *info = [NSString stringWithFormat:@"active:%zd",btn.isSelected];
    [btn setTitle:info forState:UIControlStateNormal];
    [self.scroller activeConstraint:btn.isSelected];
//    if (btn.selected) {
//        [self.constraint activate];
//    }else{
//        [self.constraint deactivate];
//    }
    //self.descLabel.text = (btn.isSelected?longString:shortString);
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
