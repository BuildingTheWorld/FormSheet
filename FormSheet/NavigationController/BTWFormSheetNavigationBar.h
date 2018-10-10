
#import <UIKit/UIKit.h>

/**
 返回按钮点击事件回调
 */
typedef void(^BTWNaviBarBackButtonClickBlock)(void);

@interface BTWFormSheetNavigationBar : UIView

/**
 控制返回按钮的显示, 默认为NO
 */
@property (nonatomic, assign, getter=isShowBackButton) BOOL showBackButton;

/**
 配置 FormSheetNavigationBar 的 title
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

@property (nonatomic, strong) BTWNaviBarBackButtonClickBlock naviBackClickBlock;

@end
