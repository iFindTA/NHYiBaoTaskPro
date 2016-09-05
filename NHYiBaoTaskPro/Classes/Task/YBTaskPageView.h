//
//  YBTaskPageView.h
//  NHYiBaoTaskPro
//
//  Created by nanhu on 16/9/4.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YBTaskPageTouchEvent)(id some);
typedef void(^YBTaskPageUpdateEvent)(int type, int count);

@interface YBTaskPageView : UIView

- (id)initWithFrame:(CGRect)frame withType:(NSUInteger)type;

/**
 *  @brief 是否需要刷新
 */
- (void)wetherShouldRefrsh;

/**
 *  @brief 更新刷新个数
 *
 *  @param event 事件
 */
- (void)handleTaskPageUpdateEvent:(YBTaskPageUpdateEvent)event;

/**
 *  @brief 点击某一行回调
 *
 *  @param event 事件
 */
- (void)handleTaskPageTouchEvent:(YBTaskPageTouchEvent)event;

@end

#pragma mark == Task Root Cell

@interface YBTaskRootCell : UITableViewCell

// 任务 时间 状态 背景
@property (nonatomic, strong) UILabel *taskLab,*timeLab,*stateLab,*bgLab,*lineLab;

//患者信息
@property (nonatomic, strong) UILabel *patientNameLab,*patientAgeLab,*patientGenderLab;

//医生信息
@property (nonatomic, strong) UIView *doctBgView;
@property (nonatomic, strong) UILabel *doctPreLab,*doctNameLab,*doctJobLab,*doctDepartLab,*doctProtocol;

//随访信息 就诊地址
@property (nonatomic, strong) UILabel *addtPreLab,*addtInfoLab;

//左边竖条
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UILabel *leftIconLab;

//布局空间
@property (nonatomic, strong) MASConstraint *doctConstraint;

/**
 *  @brief update method
 *
 *  @param aDict the info
 */
- (void)updateContent4Info:(NSDictionary *)aDict;

@end