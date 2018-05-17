//
//  ZGStudentCommontableView.h
//  ZGSegmentControl
//
//  Created by offcn_zcz32036 on 2018/5/17.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import "ZGBaseTableView.h"
#import "ZGStudentCommonCell.h"
#import "ZGStudentCommonModel.h"
@interface ZGStudentCommontableView : ZGBaseTableView
@property(nonatomic,strong)NSArray<ZGStudentCommonModel*>*students;
@end
