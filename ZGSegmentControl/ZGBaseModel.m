//
//  ZGBaseModel.m
//  ZGSegmentControl
//
//  Created by offcn_zcz32036 on 2018/5/16.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import "ZGBaseModel.h"

@implementation ZGBaseModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"ids":@"id",
             @"describe":@"description",
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
