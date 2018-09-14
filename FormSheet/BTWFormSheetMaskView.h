

#import <UIKit/UIKit.h>

/**
 点击蒙版事件回调
 */
typedef void(^BTWFormSheetBackgroundClickBlock)(void);

/**
 蒙版 View
 */
@interface BTWFormSheetMaskView : UIView

/**
 添加蒙版到窗口根控制器上
 */
- (void)addToRootViewControllerView;

@property (nonatomic, strong) BTWFormSheetBackgroundClickBlock bgClickBlock;

@end
