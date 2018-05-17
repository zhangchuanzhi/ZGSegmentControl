//
//  ZGBaseModel.h
//  ZGSegmentControl
//
//  Created by offcn_zcz32036 on 2018/5/16.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZGBaseModel : NSObject<YYModel>
@property(nonatomic,copy)NSString*ids;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)BOOL isExpand;
@end
