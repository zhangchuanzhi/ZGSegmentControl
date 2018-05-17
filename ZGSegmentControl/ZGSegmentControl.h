//
//  ZGSegmentControl.h
//  ZGSegmentControl
//
//  Created by 张传志 on 2018/5/15.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZGSegmentControl;

@protocol ZGSegmentControlDelegate <NSObject>

- (void)segmentControl:(ZGSegmentControl *)segmentControl selectIndex:(NSInteger)index;

@end

@interface ZGSegmentControl : UIView
/** 代理 */
@property (nonatomic, weak) id<ZGSegmentControlDelegate> delegate;
/** 选中时的索引 */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 默认标题数组 */
@property (nonatomic, strong) NSArray *items;
/** 默认字体大小 */
@property (nonatomic, assign) CGFloat normalSize;
/** 选中时的字体大小 */
@property (nonatomic, assign) CGFloat selectedSize;
/** 指示器的宽度 */
@property (nonatomic, assign) CGFloat indicatorWidth;
/** 未选中颜色 */
@property (nonatomic, strong) UIColor *normalColor;
/** 选中颜色 */
@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, assign) BOOL showBottomLine;

/** 获取标题的总宽度 */
+ (CGFloat)segmentControlWidthWithItems:(NSArray *)items itemsFontSize:(CGFloat)fontSize;

@end
