
#import "BTWFormSheetNavigationBar.h"

//#import <Masonry.h>

@interface BTWFormSheetNavigationBar ()

@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottonLineView;

@end

@implementation BTWFormSheetNavigationBar

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setUpSubViews];
    }
    return self;
}

#pragma mark - setUp SubViews

- (void)setUpSubViews
{
    [self addSubview:self.cornerView];
    [self addSubview:self.backButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottonLineView];
    
//    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
//    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.offset(24);
//        make.left.offset(13);
//        make.centerY.offset(0);
//    }];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.offset(0);
//    }];
//    [self.bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
//        make.height.offset(0.5);
//        make.bottom.offset(0);
//    }];
}

#pragma mark - setter

- (void)setShowBackButton:(BOOL)showBackButton
{
    _showBackButton = showBackButton;
    
    self.backButton.hidden = !showBackButton;
}

#pragma mark - action

- (void)backButtonClick:(UIButton *)sender
{
    if (self.naviBackClickBlock) {
        self.naviBackClickBlock();
    }
}

#pragma mark - lazy

- (UIView *)cornerView {
    if (_cornerView == nil) {
        _cornerView = [[UIView alloc] init];
        _cornerView.layer.cornerRadius = 10;
        _cornerView.backgroundColor = [UIColor whiteColor];
    }
    return _cornerView;
}

- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"icon_ipad_nav_back_n"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _backButton.hidden = YES;
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    }
    return _titleLabel;
}

- (UIView *)bottonLineView {
    if (_bottonLineView == nil) {
        _bottonLineView = [[UIView alloc] init];
//        _bottonLineView.backgroundColor = [UIColor colorWithRGB:0xE4E7EB];
    }
    return _bottonLineView;
}

@end
