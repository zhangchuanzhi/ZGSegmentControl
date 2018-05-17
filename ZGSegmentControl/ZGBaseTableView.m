//
//  ZGBaseTableView.m
//  ZGSegmentControl
//
//  Created by offcn_zcz32036 on 2018/5/16.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import "ZGBaseTableView.h"
#import "MJRefresh.h"
@interface ZGBaseTableView()
@property(nonatomic,strong)MJRefreshNormalHeader*headerRefresh;
@property(nonatomic,strong)MJRefreshBackNormalFooter*footerRefresh;
@property(nonatomic,weak)UIView *backView;
@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UILabel *titleLabel;
@end
@implementation ZGBaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (self) {
        [self bulidSubViews];
    }
    return self;
}
-(void)bulidSubViews
{
    self.estimatedRowHeight=0;
    self.estimatedSectionHeaderHeight=0;
    self.estimatedSectionFooterHeight=0;
    self.backgroundColor=[UIColor clearColor];
    self.headerRefresh=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pulldownRefresh)];
    self.headerRefresh.automaticallyChangeAlpha=YES;
    self.footerRefresh=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpRefresh)];
    self.footerRefresh.automaticallyChangeAlpha=YES;
    UIView *backView=[UIView new];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.size.equalTo(self);
    }];
    self.backView=backView;
    backView.hidden=YES;

    UIImageView *imageView=[UIImageView new];
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kAdaptWidth(150), kAdaptWidth(130)));
    }];
    self.imageView=imageView;
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    UILabel *titleLabel=[UILabel new];
    self.titleLabel=titleLabel;
    titleLabel.textColor=[UIColor colorWithWhite:136/255.0 alpha:1];
    titleLabel.font=[UIFont systemFontOfSize:14];
    [backView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.centerX.equalTo(imageView);
    }];
}

-(void)pulldownRefresh
{
    if (self.refreshBlock) {
        self.refreshBlock(NO);
    }
}
-(void)pullUpRefresh
{
    if (self.refreshBlock) {
        self.refreshBlock(YES);
    }
}
-(void)endRefreshing:(BOOL)isUp
{
    isUp?[self.footerRefresh endRefreshing]:[self.headerRefresh endRefreshing];
}
-(void)blankStyle:(ZGBlankStyle)style
{
    NSString*imageName=nil;
    NSString*title=nil;
    switch (style) {
        case ZGBlankStyleNoData:
            {
                imageName = @"ic_content_null";
                title = @"暂无内容";
                self.pullUp=ZGRefreshStateDisable;
            }
            break;
            case ZGBlankStyleBadNetWork:
        {
            imageName = @"ic_network_error";
            title = @"网络未连接，触屏重新加载";
            self.pullUp = ZGRefreshStateDisable;
        }
            break;

        default:
            break;
    }
}
-(void)blankImage:(NSString *)imageName title:(NSString *)title
{
    self.backView.hidden=IS_EMPTY_STRING(imageName)&&IS_EMPTY_STRING(title);
    self.imageView.image=[UIImage imageNamed:imageName];
    self.titleLabel.text=title;
}
-(void)setPulldown:(ZGRefreshState)pulldown
{
    _pulldown=pulldown;
    switch (pulldown) {
        case ZGRefreshStateNormal:
            self.mj_header=self.headerRefresh;
            break;
            case ZGRefreshStateEndRefreshing:
            [self.headerRefresh endRefreshing];
            break;
            case ZGRefreshStateBeginRefreshing:
        {
            if (!self.mj_header) {
                self.mj_header=self.headerRefresh;
            }
            [self.headerRefresh beginRefreshing];
        }
            break;

        default:
            self.mj_header=nil;
            break;
    }
}
-(void)setPullUp:(ZGRefreshState)pullUp
{
    _pullUp=pullUp;
    switch (pullUp) {
        case ZGRefreshStateNormal:
            self.mj_footer=self.footerRefresh;
            break;
            case ZGRefreshStateNoMoreData:
            [self.mj_footer endRefreshingWithNoMoreData];
            break;
            case ZGRefreshStateEnd:
        {
            MJWeakSelf;
            [self.footerRefresh endRefreshingWithCompletionBlock:^{
                __strong typeof(self)strongSelf=weakSelf;
                if (strongSelf) {
                    strongSelf.mj_footer=nil;
                }
            }];
        }
            break;
            case ZGRefreshStateEndRefreshing:
            [self.mj_footer endRefreshing];
            break;

        default:
            self.mj_footer=nil;
            break;
    }
}
@end
