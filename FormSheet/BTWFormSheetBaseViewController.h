
#import <UIKit/UIKit.h>
#import "BTWFormSheetNavigationBar.h"

/**
 FormSheetNavigationController Dismiss 回调
 */
typedef void(^BTWDidDisappearNaviCBlock)(void);

@interface BTWFormSheetBaseViewController : UIViewController

/**
 Present FormSheetNavigationController

 @param targetViewController presentingViewController
 @param viewSize formSheetNavigationController view size
 */
- (void)showNavigationControllerFromTargetViewController:(UIViewController *)targetViewController navigationControllerViewSize:(CGSize)viewSize;

/**
 Dismiss FormSheetNavigationController
 */
- (void)disappearNavigationController;

/**
 可通过此属性配置 FormSheetNavigationBar
 */
@property (nonatomic, strong, readonly) BTWFormSheetNavigationBar *formSheetNaviBar;

@property (nonatomic, strong) BTWDidDisappearNaviCBlock disappearNaviCBlock;

@end
