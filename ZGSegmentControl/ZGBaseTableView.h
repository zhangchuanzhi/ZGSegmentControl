//
//  ZGBaseTableView.h
//  ZGSegmentControl
//
//  Created by offcn_zcz32036 on 2018/5/16.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ZGBlankStyle) {
    ZGBlankStyleNormal=0,//正常
    ZGBlankStyleNoData,//没有数据
    ZGBlankStyleBadNetWork,//网络出错
};
typedef NS_ENUM(NSInteger,ZGRefreshState) {
    ZGRefreshStateNormal=0,//正常状态
    ZGRefreshStateNoMoreData,//没有更多数据
    ZGRefreshStateDisable,//刷新禁止
    ZGRefreshStateEnd,//停止刷新后禁止
    ZGRefreshStateEndRefreshing,//停止刷新
    ZGRefreshStateBeginRefreshing,//开始刷新
};
@interface ZGBaseTableView : UITableView
/**上拉状态   */
@property(nonatomic,assign)ZGRefreshState pullUp;
/**下拉状态   */
@property(nonatomic,assign)ZGRefreshState pulldown;
@property(nonatomic,copy)void(^refreshBlock)(BOOL isUp);
//空白页的样式
-(void)blankStyle:(ZGBlankStyle)style;
-(void)blankImage:(NSString*)imageName title:(NSString*)title;
@end
