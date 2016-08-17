//
//  PBFixedNavigatior.m
//  NHYiBaoTaskPro
//
//  Created by hu jiaju on 16/8/16.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import "PBFixedNavigator.h"

static const int mSubHeight                 =       40;
static const int mFlagHeight                =       2;
static const int mFontSize                  =       15;
int const mSubNavigatorHeight               =       mSubHeight;

@interface PBFixedNavigator ()

@property (nonatomic, assign) NSUInteger kIndex;
@property (nonatomic, assign) CGFloat mItemWidth;

@property (nonatomic, strong) NSArray *mTitles,*mTitItems;

@property (nonatomic, strong) CALayer *flagger;

@end

@implementation PBFixedNavigator

#pragma mark -- system init methods

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        [self __initSetup:titles];
        self.mTitles = [NSArray arrayWithArray:titles];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self __initSetup:nil];
    }
    return self;
}

- (void)__initSetup:(NSArray *)titles {
    if (titles.count) {
        self.mTitles = [NSArray arrayWithArray:titles];
        NSUInteger mCounts = titles.count;
        UIFont *normalFont = [UIFont systemFontOfSize:mFontSize];
        UIFont *boldFont = [UIFont boldSystemFontOfSize:mFontSize];
        UIColor *normalColor = [UIColor colorWithRed:46/255.f green:56/255.f blue:74/255.f alpha:1];
        UIColor *selectColor = [UIColor colorWithRed:240/255.f green:25/255.f blue:31/255.f alpha:1];
        CGFloat mItemWidth = PBSCREEN_WIDTH / mCounts;
        self.mItemWidth = mItemWidth;
        CGRect layerBounds = CGRectMake(0, mSubHeight-mFlagHeight, mItemWidth, mFlagHeight);
        CALayer *flagger = [CALayer layer];
        flagger.frame = layerBounds;
        flagger.backgroundColor = selectColor.CGColor;
        [self.layer addSublayer:flagger];
        self.flagger = flagger;
        
        self.kIndex = 0;
        __block NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
        weakify(self)
        [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            strongify(self)
            CGRect bounds = CGRectMake(mItemWidth*idx, 0, mItemWidth, mSubHeight-mFlagHeight);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = idx;
            btn.frame = bounds;
            btn.exclusiveTouch = true;
            btn.titleLabel.font = (idx == self.kIndex)?boldFont:normalFont;
            [btn setTitleColor:normalColor forState:UIControlStateNormal];
            [btn setTitleColor:selectColor forState:UIControlStateSelected];
            [btn setTitle:obj forState:UIControlStateNormal];
            [btn setTitle:obj forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(itemEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.selected = (idx == self.kIndex);
            
            [items addObject:btn];
        }];
        self.mTitItems = [items copy];
    }
}

- (void)itemEvent:(UIButton *)btn {
    NSLog(@"selected:%zd",btn.tag);
    NSUInteger __tag = [btn tag];
    if (__tag != self.kIndex) {
        if (_delegate && [_delegate respondsToSelector:@selector(fixedNavigator:didSelectIndex:)]) {
            [_delegate fixedNavigator:self didSelectIndex:__tag];
        }
        [self selected2Index:__tag];
    }
}

#pragma mark -- update method

- (void)updateFlagWithContentOffset:(CGFloat)offset {
    CGFloat real_x = (self.mItemWidth*offset)/PBSCREEN_WIDTH;
    CGRect bounds = CGRectMake(real_x,mSubHeight-mFlagHeight, self.mItemWidth, mFlagHeight);
    self.flagger.frame = bounds;
}

- (void)updateSuffix:(NSUInteger)mCount forIndex:(NSUInteger)index {
    if (mCount <= 0) {
        return;
    }
    __block UIButton *tmpBtn = nil;
    @synchronized (self.mTitItems) {
        [self.mTitItems enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == index) {
                tmpBtn = obj;
                *stop = true;
            }
        }];
    }
    if (tmpBtn != nil && index < self.mTitles.count) {
        NSString *title = self.mTitles[index];
        title = PBFormat(@"%@%zd",title,mCount);
        [tmpBtn setTitle:title forState:UIControlStateNormal];
        [tmpBtn setTitle:title forState:UIControlStateSelected];
    }
}

- (void)selected2Index:(NSUInteger)index {
    if (index == self.kIndex) {
        return;
    }
    self.kIndex = index;
    UIFont *normalFont = [UIFont systemFontOfSize:mFontSize];
    UIFont *boldFont = [UIFont boldSystemFontOfSize:mFontSize];
    @synchronized (self.mTitItems) {
        [self.mTitItems enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL selected = (idx == index);
            obj.titleLabel.font = selected?boldFont:normalFont;
            [obj setSelected:selected];
        }];
    }
    
    CGRect bounds = self.flagger.frame;
    bounds.origin.x = self.mItemWidth*index;
    [UIView animateWithDuration:PBANIMATE_DURATION animations:^{
        self.flagger.frame = bounds;
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
