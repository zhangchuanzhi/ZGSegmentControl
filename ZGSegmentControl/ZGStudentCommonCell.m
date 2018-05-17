//
//  ZGStudentCommonCell.m
//  ZGSegmentControl
//
//  Created by offcn_zcz32036 on 2018/5/16.
//  Copyright © 2018年 offcn. All rights reserved.
//

#import "ZGStudentCommonCell.h"

@interface ZGStudentCommonCell()
@property(nonatomic,strong)UILabel *nickNameLabel;
@end
@implementation ZGStudentCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildSubViews];
    }
    return self;
}
-(void)buildSubViews
{
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kAdaptWidth(15));
        make.size.mas_equalTo(CGSizeMake(46, 46));
    }];
    avatarImageView.image=[UIImage imageWithColor:[UIColor redColor]];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    avatarImageView.layer.cornerRadius = 23;
    avatarImageView.layer.masksToBounds = YES;

    UILabel *nickNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:nickNameLabel];
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(avatarImageView.mas_right).offset(6);
    }];

    nickNameLabel.text = @"韩西";
    nickNameLabel.textColor = RGBColor(35, 38, 39);
    nickNameLabel.font = FontRegularSize(15);
    self.nickNameLabel=nickNameLabel;
}
-(void)setModel:(ZGStudentCommonModel *)model
{
    _model=model;
    self.nickNameLabel.text=model.avatar=@"韩东";
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
