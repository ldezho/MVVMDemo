//
//  MMMMTableVIewCell.m
//  MVVMDemo
//
//  Created by 陈小明 on 2021/5/13.
//

#import "MVVMTableVIewCell.h"
#import <Masonry/Masonry.h>

@interface MVVMTableVIewCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,assign) NSInteger index;
@end

@implementation MVVMTableVIewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self makeMainUI];
    };
    return self;
}

- (void)makeMainUI{
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(30);
    }];
    
    _numLabel = [UILabel new];
    _numLabel.font = [UIFont systemFontOfSize:14];
    _numLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_numLabel];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-130);
    }];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setTitle:@"➕" forState:UIControlStateNormal];
    _addBtn.titleLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_addBtn];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-30);
        make.width.height.mas_equalTo(30);
    }];
    
    //直接绑定  这边有个注意Racobserve 左边只有self  右边才有viewModel.titleStr  这样就避CELL 重用的问题
    RAC(self.titleLabel,text) = RACObserve(self, cellViewModel.titleStr);
    RAC(self.numLabel,text) = RACObserve(self, cellViewModel.numStr);

    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@">>>>>");
        [self.cellViewModel.addCommand execute:nil];
    }];
}
@end
