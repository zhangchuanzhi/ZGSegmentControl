//
//  ZGStudentCommontableView.m
//  ZGSegmentControl
//
//  Created by offcn_zcz32036 on 2018/5/17.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import "ZGStudentCommontableView.h"
#import "ZGStudentCommonCell.h"
@interface ZGStudentCommontableView()
<UITableViewDelegate,UITableViewDataSource>
@end
@implementation ZGStudentCommontableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (self) {
        [self bulidSubViews];
    }
    return self;
}
-(void)bulidSubViews
{
    self.delegate=self;
    self.dataSource=self;
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator=NO;
    [self registerClass:[ZGStudentCommonCell class] forCellReuseIdentifier:NSStringFromClass([ZGStudentCommonCell class])];
}
-(void)setStudents:(NSArray<ZGStudentCommonModel *> *)students
{
    _students=students;
    [self reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.students.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section==self.students.count-1?10:CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ZGStudentCommonCell*cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZGStudentCommonCell class]) forIndexPath:indexPath];
    cell.model=self.students[indexPath.section];
    return cell;
}



@end
