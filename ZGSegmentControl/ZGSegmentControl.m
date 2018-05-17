//
//  ZGSegmentControl.m
//  ZGSegmentControl
//
//  Created by 张传志 on 2018/5/15.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import "ZGSegmentControl.h"
/** 指示器的高度 */
static CGFloat kDefaultIndicatorHeight = 2.0f;

@interface ZGSegmentControl()<UIScrollViewDelegate>
/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *segmentScrollView;
/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, strong) UIButton *currentButton;
/** 存入所有标题按钮 */
@property (nonatomic, strong) NSMutableArray *itemButtons;
@end
@implementation ZGSegmentControl
- (void)drawRect:(CGRect)rect {

    if (self.showBottomLine) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, 0, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        [RGBColor(229, 229, 229) setStroke];
        CGContextDrawPath(context, kCGPathStroke);
    }

}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSegmentControl];
    }
    return self;
}

- (void)initSegmentControl {

    self.normalSize = 15;
    self.selectedSize = 15;
    self.normalColor = [UIColor blackColor];
    self.selectedColor = [UIColor redColor];
    self.backgroundColor = [UIColor whiteColor];

    UIScrollView *segmentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.segmentScrollView = segmentScrollView;
    segmentScrollView.delegate = self;
    segmentScrollView.bounces = NO;
    segmentScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:segmentScrollView];

    // 添加指示器
    UIView *indicatorView = [[UIView alloc] init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = self.selectedColor;
    indicatorView.height = kDefaultIndicatorHeight;
    indicatorView.layer.cornerRadius = kDefaultIndicatorHeight * 0.5;
    indicatorView.top = self.height - kDefaultIndicatorHeight - (self.showBottomLine ? 1 : 0);
    [segmentScrollView addSubview:indicatorView];

}

/** 创建子控制器 */
- (void)setupSubviewsLimit:(NSInteger)limit {

    if (self.itemButtons && self.itemButtons.count > 0) {
        for (UIButton *button in self.itemButtons) {
            [button removeFromSuperview];
        }
        [self.itemButtons removeAllObjects];
    }

    CGFloat buttonOriginX = 0;
    CGFloat buttonWidth = [self calculateItemWidth];
    for (NSUInteger i = 0; i < self.items.count; i++) {
        /** 创建滚动时的标题button */
        CGRect buttonFrame = CGRectMake(buttonOriginX, 0, buttonWidth, self.height);
        UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
        button.tag = i;
        [button setTitle:self.items[i] forState:UIControlStateNormal];
        [button setTitle:self.items[i] forState:UIControlStateSelected];
        [button setTitleColor:self.normalColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:self.normalSize];
        // 点击事件
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];

        // 存入所有的title_btn
        [self.itemButtons addObject:button];
        [self.segmentScrollView addSubview:button];
        buttonOriginX += buttonWidth;

        if (i != self.items.count - 1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(buttonOriginX, 0, 1, self.height)];
            lineView.backgroundColor = RGBColor(229, 229, 229);
            [self.segmentScrollView addSubview:lineView];
        }

    }

    UIButton *lastButton = self.itemButtons.lastObject;
    self.segmentScrollView.contentSize = CGSizeMake(lastButton.right, 0);

    UIButton *firstButton = self.itemButtons.firstObject;
    [self buttonAction:firstButton];

}

- (CGFloat)calculateItemWidth {

    NSInteger limitItemCount = 5;

    if (limitItemCount > self.items.count) {
        return self.width / self.items.count;
    }
    else {
        return self.width / limitItemCount;
    }

}

#pragma mark - - - 按钮的点击事件
- (void)buttonAction:(UIButton *)button {
    // 1、代理方法实现
    NSInteger index = button.tag;
    if ([self.delegate respondsToSelector:@selector(segmentControl:selectIndex:)]) {
        [self.delegate segmentControl:self selectIndex:index];
    }

    // 2、改变选中的button的位置
    [self selectedBtnLocation:button];

}

/** 标题选中颜色改变以及指示器位置变化 */
- (void)selectedBtnLocation:(UIButton *)button {

    // 1、选中的button
    if (self.currentButton == nil) {
        button.selected = YES;
        self.currentButton = button;
        button.titleLabel.font = [UIFont systemFontOfSize:self.selectedSize];
    }else if (self.currentButton != nil && self.currentButton == button){
        button.selected = YES;
    }else if (self.currentButton != button && self.currentButton != nil){
        self.currentButton.selected = NO;
        button.selected = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:self.selectedSize];
        self.currentButton.titleLabel.font = [UIFont systemFontOfSize:self.normalSize];
        self.currentButton = button;
    }

    // 3、滚动标题选中居中
    [self selectedBtnCenter:button];
}

/** 滚动标题选中居中 */
- (void)selectedBtnCenter:(UIButton *)centerBtn {

    // 计算偏移量
    CGFloat offsetX = centerBtn.center.x - self.width * 0.5;
    offsetX = (offsetX >= 0) ? offsetX : 0;

    // 获取最大滚动范围
    CGFloat maxOffsetX = self.segmentScrollView.contentSize.width - self.width;
    offsetX = (offsetX <= maxOffsetX) ? offsetX : maxOffsetX;

    // 滚动标题滚动条
    [self.segmentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];

    // 2、改变指示器的位置
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = [self getIndexItemLenghtWith:self.items[centerBtn.tag]];
        self.indicatorView.centerX = centerBtn.centerX;
    }];
}

- (CGFloat)itemWidthWith:(NSString *)item {
    return [self titleWidthWith:item] + 28;
}

- (CGFloat)titleWidthWith:(NSString *)title {
    return [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.selectedSize]}].width;
}

- (CGFloat)getIndexItemLenghtWith:(NSString *)title {
    return 0 == self.indicatorWidth ? [self titleWidthWith:title] + 20 : self.indicatorWidth;
}

+ (CGFloat)segmentControlWidthWithItems:(NSArray *)items itemsFontSize:(CGFloat)fontSize {
    CGFloat itemsWidth = 0;
    for (NSString *item in items) {
        CGFloat itemWidth = [self itemWidthWithItem:item itemsFontSize:fontSize];
        itemsWidth += itemWidth;
    }
    return itemsWidth;
}

+ (CGFloat)itemWidthWithItem:(NSString *)item itemsFontSize:(CGFloat)fontSize {
    return [item sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}].width + 28;
}

#pragma mark - getter、setter
- (NSMutableArray *)itemButtons {
    if (!_itemButtons) {
        _itemButtons = [[NSMutableArray alloc] init];
    }
    return _itemButtons;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    self.indicatorView.backgroundColor = selectedColor;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    UIButton *selectedButton = self.itemButtons[selectedIndex];
    [self selectedBtnLocation:selectedButton];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    self.segmentScrollView.frame = self.bounds;
    self.indicatorView.top = self.height - kDefaultIndicatorHeight - (self.showBottomLine ? 1 : 0);

}

/** 设定标题数组 */
- (void)setItems:(NSArray *)items {
    _items = items;
    [self setupSubviewsLimit:items.count];
}

- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    self.indicatorView.top = self.height - kDefaultIndicatorHeight - (showBottomLine ? 1 : 0);
}

@end
