//
//  YBTaskPageView.m
//  NHYiBaoTaskPro
//
//  Created by nanhu on 16/9/4.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import "YBTaskPageView.h"

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

- (void)prepareForReuse {
    [super prepareForReuse];
    self.leftIconLab.layer.mask = nil;
    [self.doctConstraint deactivate];
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
    
    //doct bg
    [self.contentView addSubview:self.doctBgView];
    
    font = PBSysFont(15);
    color = [UIColor colorWithRed:57/255.f green:65/255.f blue:82/255.f alpha:1];
    [self.doctBgView addSubview:self.doctPreLab];
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
    self.addtInfoLab.numberOfLines = 0;
    self.addtInfoLab.preferredMaxLayoutWidth = PBSCREEN_WIDTH-10*2-80;
    
    //    [self.contentView addSubview:self.leftImg];
    [self.bgLab addSubview:self.leftIconLab];
    
    color = [UIColor colorWithRed:237/255.f green:240/255.f blue:243/255.f alpha:1];
    self.contentView.backgroundColor = color;
    
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
    
    //医生前缀
    [self.doctBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.patientNameLab.mas_bottom).offset(5);
        make.left.equalTo(self.patientNameLab);
        make.right.equalTo(self.patientNameLab);
        //make.height.equalTo(@20);
        
        self.doctConstraint = make.height.equalTo(@0).priority(UILayoutPriorityRequired);
    }];
    [self.doctConstraint deactivate];
    [self.doctPreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.doctBgView).offset(5);
        make.left.equalTo(self.doctBgView);
        make.bottom.equalTo(self.doctBgView).offset(-5).priorityMedium(500);
        //make.right.equalTo(self.patientNameLab);
        //make.height.equalTo(@20);
    }];
    
    
    //就诊地址
    [self.addtPreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.doctBgView.mas_bottom).offset(5);
        make.left.equalTo(self.doctBgView);
        make.height.equalTo(@20);
    }];
    
    //就诊信息
    self.addtInfoLab.preferredMaxLayoutWidth = PBSCREEN_WIDTH-10*2-80;
    [self.addtInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.equalTo(self.addtPreLab);
        make.left.equalTo(self.addtPreLab.mas_right).offset(5);
        make.height.mas_greaterThanOrEqualTo(@20).priorityMedium(500);
    }];
    
    [self.leftIconLab mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.top.left.bottom.equalTo(self.bgLab);
        make.width.equalTo(@5);
    }];
    
    //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.leftIconLab.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(4,4)];
    //    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //    maskLayer.frame = self.leftIconLab.bounds;
    //    maskLayer.path = maskPath.CGPath;
    //    self.leftIconLab.layer.mask = maskLayer;
    //    self.maskLayer = maskLayer;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(PBSCREEN_WIDTH));
        make.top.left.equalTo(@0);
        make.bottom.equalTo(self.addtInfoLab.mas_bottom).offset(15);
    }];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)updateContent4Info:(NSDictionary *)aDict {
    
    NSUInteger type = [[aDict objectForKey:@"tasktype"] integerValue];
    NSString *typeTitle = nil;NSString *imgName = nil;
    UIColor *leftColor = nil;BOOL hidden = false;
    if (type == 0) {
        typeTitle = @"驻院诊导任务";
        imgName = @"p_zhuyuandaozhen";
        leftColor = [UIColor colorWithRed:125/255.f green:196/255.f blue:240/255.f alpha:1];
    }else if (type == 1){
        typeTitle = @"随访任务";
        imgName = @"p_suifang";
        leftColor = [UIColor colorWithRed:146/255.f green:221/255.f blue:161/255.f alpha:1];
        hidden = true;
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
    
    if (hidden) {
        //self.doctPreLab.hidden = hidden;
        [self.doctConstraint activate];
    }
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    
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

- (UIView *)doctBgView {
    if (!_doctBgView) {
        UIView *tmp = [[UIView alloc] initWithFrame:CGRectZero];
        tmp.backgroundColor = [UIColor blueColor];
        tmp.layer.masksToBounds = true;
        _doctBgView = tmp;
    }
    return _doctBgView;
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

@interface YBTaskPageView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSUInteger type;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *table;

@property (nonatomic, copy) YBTaskPageUpdateEvent updateEvent;
@property (nonatomic, copy) YBTaskPageTouchEvent touchEvent;

@end

@implementation YBTaskPageView

- (id)initWithFrame:(CGRect)frame withType:(NSUInteger)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self __initSetup];
    }
    return self;
}

- (void)__initSetup {
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = [UIColor pb_randomColor];
    table.dataSource = self;
    table.estimatedRowHeight = 100;
    table.tableFooterView = [[UIView alloc] init];
    [self addSubview:table];
    self.table = table;
    weakify(self)
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        strongify(self)
        make.edges.equalTo(self);
    }];
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        strongify(self)
        [self refreshing];
    }];
    table.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        strongify(self)
        [self loadMore];
    }];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

NSString *something = @"相声（Crosstalk)一种民间说唱曲艺。相声一词，古作象生，原指模拟别人的言行，后发展为象声。象声又称隔壁象声。相声起源于华北地区的民间说唱曲艺，在明朝即已盛行。经清朝时期的发展直至民国初年，相声逐渐从一个人摹拟口技发展成为单口笑话，名称也就随之转变为相声。一种类型的单口相声，后来逐步发展为多种类型：单口相声、对口相声、群口相声";

- (int)random:(int)min max:(int)max {
    return arc4random()%(max-min) + min;
}

- (void)wetherShouldRefrsh {
    [self.table.mj_header beginRefreshing];
}

- (void)refreshing {
    
    NSArray *arr = self.dataSource.copy;
    if (PBIsEmpty(arr)) {
        NSUInteger mCount = 50;
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
        int len = (int)[something length];
        for (int i = 0; i < mCount; i ++) {
            NSString *addtInfo = [something substringToIndex:[self random:0 max:len]];
            //NSLog(@"generate info :%@",addtInfo);
            NSDictionary *dict = @{
                                   @"tasktype":PBFormat(@"%zd",i%3),
                                   @"patient":@"马天明",
                                   @"doctpre":@"医生信息",
                                   @"addtpre":(i%2==0)?@"随访信息":@"就诊地址",
                                   @"addtinfo":(i%2==0)?@"":addtInfo
                                   };
            [tmp addObject:dict];
        }
        
        [self.dataSource addObjectsFromArray:tmp.copy];
        [self.table reloadData];
    }
    
    [self.table.mj_header endRefreshing];
    
    //TODO:这里为测试刷新标题 正式过程需要去掉
    if (self.updateEvent) {
        self.updateEvent((int)self.type, [self random:0 max:100]);
    }
}

- (void)loadMore {
    
}

#pragma mark -- UITableView 's delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *tmpSource = [self.dataSource copy];
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
    
    NSArray *tmpSource = [self.dataSource copy];
    NSUInteger __row = [indexPath row];
    [cell updateContent4Info:tmpSource[__row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *tmpSource = [self.dataSource copy];
    NSUInteger __row = [indexPath row];
    if (self.touchEvent) {
        self.touchEvent(tmpSource[__row]);
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)handleTaskPageUpdateEvent:(YBTaskPageUpdateEvent)event {
    self.updateEvent = [event copy];
}

- (void)handleTaskPageTouchEvent:(YBTaskPageTouchEvent)event {
    self.touchEvent = [event copy];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
