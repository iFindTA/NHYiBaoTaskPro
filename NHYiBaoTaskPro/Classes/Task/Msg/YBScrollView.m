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
@property (nonatomic, strong) UILabel *label;

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
    
    [self.contentView addSubview:self.label];
    
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
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@1000);
    }];
    //最后布局content
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
        make.bottom.equalTo(self.label);
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

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor purpleColor];
    }
    return _label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
