//
//  ZGAdaptTool.h
//  ZGSegmentControl
//
//  Created by offcn_zcz32036 on 2018/5/17.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGAdaptTool : NSObject
/**
 屏幕适配宽
 */
+ (CGFloat)widthAdaptScale;

/**
 屏幕适配高
 */
+ (CGFloat)heightAdaptScale:(BOOL)isSafe;
@end
