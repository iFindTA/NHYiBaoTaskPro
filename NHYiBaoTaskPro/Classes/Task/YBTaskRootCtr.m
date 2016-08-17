//
//  YBTaskRootCtr.m
//  NHYiBaoTaskPro
//
//  Created by hu jiaju on 16/8/16.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import "YBTaskRootCtr.h"
#import "PBFixedNavigator.h"

#pragma mark == Task Root Cell

@interface YBTaskRootCell : UITableViewCell

// 任务 时间 状态 背景
@property (nonatomic, strong) UILabel *taskLab,*timeLab,*stateLab,*bgLab,*lineLab;

//患者信息
@property (nonatomic, strong) UILabel *patientNameLab,*patientAgeLab,*patientGenderLab;

//医生信息
@property (nonatomic, strong) UILabel *doctPreLab,*doctNameLab,*doctJobLab,*doctDepartLab,*doctProtocol;

//随访信息 就诊地址
@property (nonatomic, strong) UILabel *addtPreLab,*addtInfoLab;

//左边竖条
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UILabel *leftIconLab;

/**
 *  @brief update method
 *
 *  @param aDict the info
 */
- (void)updateContent4Info:(NSDictionary *)aDict;

@end

@implementation YBTaskRootCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self __initSetup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self __initSetup];
    }
    return self;
}

- (void)awakeFromNib {
    [self __initSetup];
}

- (void)__initSetup {
    
    [self.contentView addSubview:self.bgLab];
//    self.bgLab.backgroundColor = [UIColor yellowColor];
    
    UIFont *font = PBSysFont(15);
    UIColor *color = [UIColor colorWithRed:68/255.f green:65/255.f blue:52/255.f alpha:1];
    [self.contentView addSubview:self.taskLab];
    self.taskLab.font = font;
    self.taskLab.textColor = color;
    
    color = [UIColor colorWithRed:234/255.f green:234/255.f blue:234/255.f alpha:1];
    [self.contentView addSubview:self.lineLab];
    self.lineLab.backgroundColor = color;
    
    font = PBSysBoldFont(15);
    color = [UIColor colorWithRed:53/255.f green:61/255.f blue:79/255.f alpha:1];
    [self.contentView addSubview:self.patientNameLab];
    self.patientNameLab.font = font;
    self.patientNameLab.textColor = color;
    
    font = PBSysFont(15);
    color = [UIColor colorWithRed:57/255.f green:65/255.f blue:82/255.f alpha:1];
    [self.contentView addSubview:self.doctPreLab];
    self.doctPreLab.font = font;
    self.doctPreLab.textColor = color;
    
    [self.contentView addSubview:self.addtPreLab];
    self.addtPreLab.font = font;
    self.addtPreLab.textColor = color;
    
    color = [UIColor colorWithRed:110/255.f green:118/255.f blue:134/255.f alpha:1];
    [self.contentView addSubview:self.addtInfoLab];
    self.addtInfoLab.font = font;
    self.addtInfoLab.textColor = color;
    self.addtInfoLab.lineBreakMode = NSLineBreakByCharWrapping;
    self.addtInfoLab.numberOfLines = 2;
    self.addtInfoLab.preferredMaxLayoutWidth = PBSCREEN_WIDTH-10*2-70;
    
//    [self.contentView addSubview:self.leftImg];
    [self.contentView addSubview:self.leftIconLab];
    
    color = [UIColor colorWithRed:237/255.f green:240/255.f blue:243/255.f alpha:1];
    self.contentView.backgroundColor = color;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)updateContent4Info:(NSDictionary *)aDict {
    
    NSUInteger type = [[aDict objectForKey:@"tasktype"] integerValue];
    NSString *typeTitle = nil;NSString *imgName = nil;
    UIColor *leftColor = nil;
    if (type == 0) {
        typeTitle = @"驻院诊导任务";
        imgName = @"p_zhuyuandaozhen";
        leftColor = [UIColor colorWithRed:125/255.f green:196/255.f blue:240/255.f alpha:1];
    }else if (type == 1){
        typeTitle = @"随访任务";
        imgName = @"p_suifang";
        leftColor = [UIColor colorWithRed:146/255.f green:221/255.f blue:161/255.f alpha:1];
    }else if (type == 2){
        typeTitle = @"全程陪诊任务";
        imgName = @"p_quanchengpeizhen";
        leftColor = [UIColor colorWithRed:156/255.f green:174/255.f blue:226/255.f alpha:1];
    }
    self.taskLab.text = typeTitle;
    
    NSString *info = [aDict objectForKey:@"patient"];
    self.patientNameLab.text = info;
    
    info = [aDict objectForKey:@"doctpre"];
    self.doctPreLab.text = info;
    
    info = [aDict objectForKey:@"addtpre"];
    self.addtPreLab.text = info;
    
    info = [aDict objectForKey:@"addtinfo"];
    self.addtInfoLab.text = info;
    [self.addtInfoLab sizeToFit];
    
//    UIImage *img = [UIImage imageNamed:imgName];
//    CGFloat capWidth = img.size.width / 2;
//    CGFloat capHeight = img.size.height / 2;
//    img = [img stretchableImageWithLeftCapWidth:capWidth topCapHeight:capHeight];
//    self.leftImg.image = img;
    
    self.leftIconLab.backgroundColor = leftColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    weakify(self)
    [self.bgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    
    //任务布局
    [self.taskLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@20);
    }];
    
    //分割线布局
    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.taskLab.mas_bottom).offset(5);
        make.left.right.equalTo(self.taskLab);
        make.height.equalTo(@1);
    }];
    
    //病人名字布局
    [self.patientNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.lineLab.mas_bottom).offset(5);
        make.left.equalTo(self.lineLab);
        make.right.equalTo(self.lineLab);
        make.height.equalTo(@20);
    }];
    
    [self.doctPreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.patientNameLab.mas_bottom).offset(5);
        make.left.equalTo(self.patientNameLab);
        make.right.equalTo(self.patientNameLab);
        make.height.equalTo(@20);
    }];
    
    [self.addtPreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.doctPreLab.mas_bottom).offset(5);
        make.left.equalTo(self.doctPreLab);
        make.height.equalTo(@20);
    }];
    
    self.addtInfoLab.preferredMaxLayoutWidth = PBSCREEN_WIDTH-10*2-70;
    [self.addtInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.addtPreLab);
        make.left.equalTo(self.addtPreLab.mas_right).offset(5);
    }];
    
    //左边图片
//    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        strongify(self)
//        make.top.equalTo(self.taskLab);
//        make.left.equalTo(self.contentView).offset(5);
//        make.bottom.equalTo(self.addtInfoLab).priorityLow(998);
//        make.width.equalTo(@5);
//    }];
    [self.leftIconLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.left.bottom.equalTo(self.bgLab);
        make.width.equalTo(@5);
    }];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.leftIconLab.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(4,4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.leftIconLab.bounds;
    maskLayer.path = maskPath.CGPath;
    self.leftIconLab.layer.mask = maskLayer;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(PBSCREEN_WIDTH));
        make.bottom.equalTo(self.addtInfoLab.mas_bottom).offset(15);
    }];
    
}

#pragma mark -- lazy methods

- (UIImageView *)leftImg {
    if (!_leftImg) {
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.contentMode = UIViewContentModeScaleAspectFill;
        _leftImg = imgv;
    }
    return _leftImg;
}

- (UILabel *)taskLab {
    if (!_taskLab) {
        UILabel *label = [[UILabel alloc] init];
        _taskLab = label;
    }
    return _taskLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        UILabel *label = [[UILabel alloc] init];
        _timeLab = label;
    }
    return _timeLab;
}

- (UILabel *)stateLab {
    if (!_stateLab) {
        UILabel *label = [[UILabel alloc] init];
        _stateLab = label;
    }
    return _stateLab;
}

- (UILabel *)bgLab {
    if (!_bgLab) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.layer.cornerRadius = 4;
        label.layer.masksToBounds = true;
        _bgLab = label;
    }
    return _bgLab;
}

- (UILabel *)lineLab {
    if (!_lineLab) {
        UILabel *label = [[UILabel alloc] init];
        _lineLab = label;
    }
    return _lineLab;
}

- (UILabel *)patientNameLab {
    if (!_patientNameLab) {
        UILabel *label = [[UILabel alloc] init];
        _patientNameLab = label;
    }
    return _patientNameLab;
}

- (UILabel *)patientAgeLab {
    if (!_patientAgeLab) {
        UILabel *label = [[UILabel alloc] init];
        _patientAgeLab = label;
    }
    return _patientAgeLab;
}

- (UILabel *)patientGenderLab {
    if (!_patientGenderLab) {
        UILabel *label = [[UILabel alloc] init];
        _patientGenderLab = label;
    }
    return _patientGenderLab;
}

- (UILabel *)doctPreLab {
    if (!_doctPreLab) {
        UILabel *label = [[UILabel alloc] init];
        _doctPreLab = label;
    }
    return _doctPreLab;
}

- (UILabel *)doctNameLab {
    if (!_doctNameLab) {
        UILabel *label = [[UILabel alloc] init];
        _doctNameLab = label;
    }
    return _doctNameLab;
}

- (UILabel *)doctJobLab {
    if (!_doctJobLab) {
        UILabel *label = [[UILabel alloc] init];
        _doctJobLab = label;
    }
    return _doctJobLab;
}

- (UILabel *)doctDepartLab {
    if (!_doctDepartLab) {
        UILabel *label = [[UILabel alloc] init];
        _doctDepartLab = label;
    }
    return _doctDepartLab;
}

- (UILabel *)doctProtocol {
    if (!_doctProtocol) {
        UILabel *label = [[UILabel alloc] init];
        _doctProtocol = label;
    }
    return _doctProtocol;
}

- (UILabel *)addtPreLab {
    if (!_addtPreLab) {
        UILabel *label = [[UILabel alloc] init];
        _addtPreLab = label;
    }
    return _addtPreLab;
}

- (UILabel *)addtInfoLab {
    if (!_addtInfoLab) {
        UILabel *label = [[UILabel alloc] init];
        _addtInfoLab = label;
    }
    return _addtInfoLab;
}

- (UILabel *)leftIconLab {
    if (!_leftIconLab) {
        UILabel *label = [[UILabel alloc] init];
        _leftIconLab = label;
    }
    return _leftIconLab;
}

@end

#pragma mark == Task Root CTR

@interface YBTaskRootCtr ()<UIScrollViewDelegate, PBFixedNavigatorDelegate, UITableViewDelegate, UITableViewDataSource>{
    BOOL loadState[10];
}

@property (nonatomic, assign) BOOL isInited;
@property (nonatomic, assign) NSUInteger preIdx;
@property (nonatomic, strong) PBFixedNavigator *navigator;
@property (nonatomic, strong) UIView *contanier;
@property (nonatomic, strong) UIScrollView *scroller;

@property (nonatomic, strong) NSArray *tables;
@property (nonatomic, strong) NSMutableArray *mBeforeSource,*mTodaySource,*mTomorrowSource,*mAfterSource,*mAllSource;
@property (nonatomic, strong) UITableView *mBeforeTable;

@property (nonatomic, strong) YBTaskRootCell *dynamicCell;

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
    NSMutableArray *mTables = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < mCounts; i ++) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.backgroundColor = [UIColor pb_randomColor];
        table.dataSource = self;
        table.estimatedRowHeight = 100;
        table.tableFooterView = [[UIView alloc] init];
        [container addSubview:table];
        if (i==0) {
            self.mBeforeTable = table;
        }
        [table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(container);
            make.left.equalTo(container).offset(PBSCREEN_WIDTH*i);
            make.width.equalTo(@(PBSCREEN_WIDTH));
        }];
        table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            strongify(self)
            [self refreshing];
        }];
        table.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            strongify(self)
            [self loadMore];
        }];
        
        loadState[i] = false;
        [mTables addObject:table];
        mLast = table;
        
    }
    self.tables = [mTables copy];
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

#pragma mark -- getter methods

- (NSString *)title4Index:(NSUInteger)index {
    NSString *title = nil;
    if (index == 0) {
        title = @"以前";
    }else if (index == 1){
        title = @"今天";
    }else if (index == 2){
        title = @"明天";
    }else if (index == 3){
        title = @"以后";
    }else if (index == 4){
        title = @"全部";
    }
    return title;
}

- (NSArray *)dataSource4Index:(NSUInteger)index {
    NSArray *arr = nil;
    
    if (index == 0) {
        arr = self.mBeforeSource.copy;
    }else if (index == 1){
        arr = self.mTodaySource.copy;
    }else if (index == 2){
        arr = self.mTomorrowSource.copy;
    }else if (index == 3){
        arr = self.mAfterSource.copy;
    }else if (index == 4){
        arr = self.mAllSource.copy;
    }
    
    return arr;
}

- (NSUInteger)currentPageIdx {
    float offset = self.scroller.contentOffset.x;
    CGFloat width = floorf(CGRectGetWidth(self.scroller.bounds));
    NSUInteger idx = (offset + (width * 0.5)) / width;
    return idx;
}

#pragma mark -- Scroller's delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.navigator) {
        [self.navigator updateFlagWithContentOffset:scrollView.contentOffset.x];
    }
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
    
    NSArray *dataSource = [self dataSource4Index:self.preIdx];
    if (!dataSource || dataSource.count == 0) {
        //如果此页面从未加载过数据 则马上加载
        if (!loadState[self.preIdx]) {
            UITableView *table = self.tables[self.preIdx];
            [table.mj_header beginRefreshing];
            loadState[self.preIdx] = true;
            return;
        }else{
            //加载过 且没有数据 则显示暂无数据
        }
    }
}

NSString *something = @"相声（Crosstalk)一种民间说唱曲艺。相声一词，古作象生，原指模拟别人的言行，后发展为象声。象声又称隔壁象声。相声起源于华北地区的民间说唱曲艺，在明朝即已盛行。经清朝时期的发展直至民国初年，相声逐渐从一个人摹拟口技发展成为单口笑话，名称也就随之转变为相声。一种类型的单口相声，后来逐步发展为多种类型：单口相声、对口相声、群口相声";

- (int)random:(int)min max:(int)max {
    return arc4random()%(max-min) + min;
}

- (void)refreshing {
    
    NSArray *arr = [self dataSource4Index:self.preIdx];
    if (PBIsEmpty(arr)) {
        NSUInteger mCount = 6;
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
        //int len = (int)[something length];
        for (int i = 0; i < mCount; i ++) {
            NSString *addtInfo = [something substringToIndex:[self random:10 max:40]];
            //NSLog(@"generate info :%@",addtInfo);
            NSDictionary *dict = @{
                                   @"tasktype":PBFormat(@"%zd",i%3),
                                   @"patient":@"马天明",
                                   @"doctpre":@"医生信息",
                                   @"addtpre":(i%2==0)?@"随访信息":@"就诊地址",
                                   @"addtinfo":addtInfo
                                   };
            [tmp addObject:dict];
        }
        
        self.mBeforeSource = [NSMutableArray arrayWithArray:tmp.copy];
        UITableView *table = self.tables[0];
        [table reloadData];
    }
    
    UITableView *table = self.tables[self.preIdx];
    [table.mj_header endRefreshing];
    
    //TODO:这里为测试刷新标题 正式过程需要去掉
    if (self.navigator) {
        [self.navigator updateSuffix:[self random:0 max:100] forIndex:self.preIdx];
    }
}

- (void)loadMore {
    
}

#pragma mark -- UITableView 's delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *tmpSource = [self dataSource4Index:self.preIdx];
    return tmpSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *tmpSource = [self dataSource4Index:self.preIdx];
    NSUInteger __row = [indexPath row];
    /*
    [self.dynamicCell updateContent4Info:tmpSource[__row]];
    CGSize size = [self.dynamicCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //*/
    
    static YBTaskRootCell *calculateCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (calculateCell == nil) {
            calculateCell = [[YBTaskRootCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
    });
    [calculateCell updateContent4Info:tmpSource[__row]];
    CGSize size = [calculateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    YBTaskRootCell *cell = (YBTaskRootCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[YBTaskRootCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    NSArray *tmpSource = [self dataSource4Index:self.preIdx];
    NSUInteger __row = [indexPath row];
    [cell updateContent4Info:tmpSource[__row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
