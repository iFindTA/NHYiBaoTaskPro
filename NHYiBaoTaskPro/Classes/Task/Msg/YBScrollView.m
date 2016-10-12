//
//  YBScrollView.m
//  NHYiBaoTaskPro
//
//  Created by nanhu on 16/8/31.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import "YBScrollView.h"

@interface YBScrollView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, strong) UIView *taskView,*recordView;

@property (nonatomic, strong) MASConstraint *constraint;

@end

@implementation YBScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self __initSetup];
    }
    return self;
}

- (void)__initSetup {
    
    //[self addSubview:self.contentView];
    
    UIView *task = [[UIView alloc] init];
    task.backgroundColor = [UIColor pb_randomColor];
    [self addSubview:task];
    self.taskView = task;
    UIView *record = [[UIView alloc] init];
    record.backgroundColor = [UIColor pb_randomColor];
    [self addSubview:record];
    self.recordView = record;
    self.isActive = false;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //首先布局自身
    weakify(self)
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(@0);
        make.width.equalTo(@(PBSCREEN_WIDTH));
        //make.height.equalTo(@(PBSCREEN_HEIGHT));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.left.right.equalTo(self);
        make.width.equalTo(@(PBSCREEN_WIDTH));
        //make.top.left.right.equalTo(self);
    }];
    //其次布局内容
    [self.taskView mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.left.right.equalTo(self);
        make.height.equalTo(@500);
    }];
    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.taskView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@450).priority(UILayoutPriorityDefaultHigh);
        self.constraint = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
    }];
    if (self.isActive) {
        [self.constraint activate];
    }else{
        [self.constraint deactivate];
    }
    //最后布局content
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        strongify(self)
//        make.bottom.equalTo(self.recordView);
//    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(@0);
        //make.width.equalTo(@(PBSCREEN_WIDTH));
        make.bottom.equalTo(self.recordView.mas_bottom);
    }];
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contaner = [[UIView alloc] initWithFrame:CGRectZero];
        contaner.backgroundColor = [UIColor yellowColor];
        _contentView = contaner;
    }
    return _contentView;
}

- (void)activeConstraint:(BOOL)active {
    self.isActive = active;
    [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
