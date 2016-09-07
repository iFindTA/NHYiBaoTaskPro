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
    
    [self addSubview:self.contentView];
    
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
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(PBSCREEN_WIDTH));
        make.height.equalTo(@(PBSCREEN_HEIGHT));
    }];
    //其次布局内容
    [self.taskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@200);
    }];
    [self.recordView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(200);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@150).priority(UILayoutPriorityDefaultHigh);
        if (!self.constraint) {
            self.constraint = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
        }
    }];
    if (self.isActive) {
        [self.constraint activate];
    }else{
        [self.constraint deactivate];
    }
    //最后布局content
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
        make.bottom.equalTo(self.recordView);
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
