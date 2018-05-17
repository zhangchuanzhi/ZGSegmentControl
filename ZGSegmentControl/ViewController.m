//
//  ViewController.m
//  ZGSegmentControl
//
//  Created by 张传志 on 2018/5/15.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import "ViewController.h"
#import "ZGSegmentControl.h"
#import "ZGStudentCommontableView.h"
@interface ViewController ()<ZGSegmentControlDelegate>
@property(nonatomic,strong)UIScrollView*scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"展示";
    [self buildSubViews];
}
-(void)buildSubViews
{
    NSArray*items=@[@"已完善",@"未完善"];
    ZGSegmentControl *segmentControl=[[ZGSegmentControl alloc]initWithFrame:CGRectMake(0, kHeightNavigationBar, SCREEN_WIDTH, 44)];
    segmentControl.delegate=self;
    segmentControl.normalColor=RGBColor(122, 133, 145);
    segmentControl.selectedColor=ThemeColor;
    segmentControl.normalSize=15;
    segmentControl.showBottomLine=YES;
    segmentControl.items=items;
    [self.view addSubview:segmentControl];
    UIScrollView*scrollView=[UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(segmentControl.mas_bottom);
    }];
    self.scrollView=scrollView;
    scrollView.scrollEnabled=NO;

    UIView *contentView=[UIView new];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        make.height.equalTo(scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH*items.count);
    }];
    NSMutableArray*subViews=[[NSMutableArray alloc]initWithCapacity:items.count];
    for (int i=0; i<items.count; i++) {
        ZGStudentCommontableView*tableView=[[ZGStudentCommontableView alloc]init];
        [contentView addSubview:tableView];
        [subViews addObject:tableView];
        NSMutableArray *data=[NSMutableArray new];
        for (int i=0; i<10; i++) {
            ZGStudentCommonModel *model=[ZGStudentCommonModel new];
            [data addObject:model];
        }
        tableView.students=data;
    }
    [subViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:SCREEN_WIDTH leadSpacing:0 tailSpacing:0];
    [subViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];
    
}
-(void)segmentControl:(ZGSegmentControl *)segmentControl selectIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
