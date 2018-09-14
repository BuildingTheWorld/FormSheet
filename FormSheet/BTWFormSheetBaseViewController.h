

#import "BTWFormSheetNavigationBar.h"
#import "BTWFormSheetNavigationController.h"

static CGFloat const kFormSheetNavigationBarHeight = 44;

/**
 BTWFormSheetNavigationController 移除回调
 */
typedef void(^BTWFormSheetNaviCDidRemoveBlock)(void);

/**
 BTWIPadFormSheetBaseViewController 移除回调
 */
typedef void(^BTWFormSheetVCDidRemoveBlock)(void);

@interface BTWFormSheetBaseViewController : UIViewController

@property (nonatomic, strong, readonly) BTWFormSheetNavigationBar *formSheetNaviBar;

/**
 将 BTWFormSheetNavigationController 添加到 targetVC

 @param targetVC 目标VC
 @param naviCViewSize BTWFormSheetNavigationController 控制器的 View 的 Size
 @param transitionStyle 添加时的动画样式
 */
- (void)navigationControllerAddToTargetViewController:(UIViewController *)targetVC navigationControlleViewSize:(CGSize)naviCViewSize transitionStyle:(BTWFormSheetTransitionStyle)transitionStyle;

/**
 将 BTWFormSheetNavigationController 从 targetVC 移除

 @param targetVC 目标VC
 @param transitionStyle 移除时的动画样式
 */
- (void)navigationControllerRemoveFromTargetViewController:(UIViewController *)targetVC transitionStyle:(BTWFormSheetTransitionStyle)transitionStyle;

@property (nonatomic, strong) BTWFormSheetNaviCDidRemoveBlock naviCDidRemoveBlock;

/**
 将 BTWFormSheetBaseViewController 添加到 UIWindow 的 RootViewController

 @param viewSize BTWFormSheetBaseViewController 控制器的 View 的 Size
 */
- (void)addToWindowRootViewControllerWithViewSize:(CGSize)viewSize;

/**
 将 CSIPadFormSheetBaseViewController 从 UIWindow 的 RootViewController 移除
 */
- (void)removeFromWindowRootViewController;

@property (nonatomic, strong) BTWFormSheetVCDidRemoveBlock vcDidRemoveBlock;

@end
