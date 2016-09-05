//
//  YBTaskRootCtr.m
//  NHYiBaoTaskPro
//
//  Created by hu jiaju on 16/8/16.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import "YBTaskRootCtr.h"
#import "PBFixedNavigator.h"
#import "YBTaskPageView.h"

#pragma mark == Task Root CTR

@interface YBTaskRootCtr ()<UIScrollViewDelegate, PBFixedNavigatorDelegate>

@property (nonatomic, assign) BOOL isInited;
@property (nonatomic, assign) NSUInteger preIdx;
@property (nonatomic, strong) PBFixedNavigator *navigator;
@property (nonatomic, strong) UIView *contanier;
@property (nonatomic, strong) UIScrollView *scroller;

@property (nonatomic, strong) NSMutableArray *pageSets;

@end

@implementation YBTaskRootCtr

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_isInited) {
        _isInited = true;
        [self renderTaskBody];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"size:%@",NSStringFromCGSize(self.contanier.bounds.size));
}

- (void)renderTaskBody {
    
    if (_scroller) {
        return;
    }
    
    //sub navigator
    CGFloat mSubNaviHeight = mSubNavigatorHeight;
    NSArray *titles = @[@"以前",@"今天",@"明天",@"以后",@"全部"];
    PBFixedNavigator *navigator = [[PBFixedNavigator alloc] initWithFrame:CGRectZero withTitles:titles];
    navigator.delegate = self;
    [self.view addSubview:navigator];
    self.navigator = navigator;
    weakify(self);
    [navigator mas_makeConstraints:^(MASConstraintMaker *make) {
       strongify(self)
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(mSubNaviHeight));
    }];
    
    UIScrollView *scroller = [[UIScrollView alloc] init];
    scroller.showsVerticalScrollIndicator = false;
    scroller.showsHorizontalScrollIndicator = false;
    scroller.pagingEnabled = true;
    scroller.delegate = self;
    [self.view addSubview:scroller];
    self.scroller = scroller;
    
    CGFloat mTabBarHeight = 49;
    [scroller mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(mSubNaviHeight, 0, mTabBarHeight, 0));
    }];
    
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = [UIColor whiteColor];
    [scroller addSubview:container];
    self.contanier = container;
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroller);
        make.height.equalTo(scroller);
    }];
    
    NSUInteger mCounts = 5;UIView *mLast = nil;
    NSMutableArray *mSets = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < mCounts; i ++) {
        YBTaskPageView *pager = [[YBTaskPageView alloc] initWithFrame:CGRectZero withType:i];
        [self.contanier addSubview:pager];
        weakify(self)
        [pager handleTaskPageUpdateEvent:^(int type, int count) {
            strongify(self)
            [self refreshCount:count forType:type];
        }];
        [pager handleTaskPageTouchEvent:^(id some) {
            
        }];
        [pager mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(container);
            make.left.equalTo(container).offset(PBSCREEN_WIDTH*i);
            make.width.equalTo(@(PBSCREEN_WIDTH));
        }];
        
        [mSets addObject:pager];
        mLast = pager;
        
    }
    self.pageSets = [mSets copy];
//    [self.mBeforeTable registerClass:[YBTaskRootCell class] forCellReuseIdentifier:@"cell"];
//    self.dynamicCell = [[YBTaskRootCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    //tel it layout was ended
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mLast.mas_right);
    }];
    
    self.preIdx = 0;
    //默认加载第一个item数据
    [self wetherShouldLoadDatas];
}

- (void)refreshCount:(int)count forType:(NSUInteger)idx {
    //TODO:这里为测试刷新标题 正式过程需要去掉
    if (self.navigator) {
        [self.navigator updateSuffix:count forIndex:idx];
    }
}

#pragma mark -- getter methods

- (NSUInteger)currentPageIdx {
    float offset = self.scroller.contentOffset.x;
    CGFloat width = floorf(CGRectGetWidth(self.scroller.bounds));
    NSUInteger idx = (offset + (width * 0.5)) / width;
    return idx;
}

#pragma mark -- Scroller's delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //TODO:跟随移动flagger
    if (self.navigator) {
        [self.navigator updateFlagWithContentOffset:scrollView.contentOffset.x];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (self.navigator) {
//        [self.navigator updateFlagWithContentOffset:scrollView.contentOffset.x];
//    }
    [self scrollerDidEnd];
}

#pragma mark -- Sub Navigator's delegate

- (void)fixedNavigator:(PBFixedNavigator *)navigator didSelectIndex:(NSUInteger)index {
    if (index == self.preIdx) {
        return;
    }
    self.preIdx = index;
    CGFloat width = floorf(CGRectGetWidth(self.scroller.bounds));
    CGFloat offset = width*index;
    [self.scroller setContentOffset:CGPointMake(offset, 0) animated:true];
    [self wetherShouldLoadDatas];
}

#pragma mark -- load datas

- (void)scrollerDidEnd {
    NSLog(@"did end");
    NSUInteger currentPage = [self currentPageIdx];
    if (currentPage == self.preIdx) {
        return;
    }
    if (self.navigator) {
        [self.navigator selected2Index:currentPage];
    }
    self.preIdx = currentPage;
    [self wetherShouldLoadDatas];
}

- (void)wetherShouldLoadDatas {
    
    YBTaskPageView *page = [self.pageSets objectAtIndex:self.preIdx];
    [page wetherShouldRefrsh];
}

@end
