

#import <UIKit/UIKit.h>

/**
 bar backButton click
 */
typedef void(^BTWNaviBarBackButtonClickBlock)(void);

@interface BTWFormSheetNavigationBar : UIView

/**
 是否显示返回按钮
 */
@property (nonatomic, assign, getter=isShowBackButton) BOOL showBackButton;

@property (nonatomic, strong, readonly) UILabel *titleLabel;

@property (nonatomic, strong) BTWNaviBarBackButtonClickBlock naviBackClickBlock;

@end
