
#import <UIKit/UIKit.h>

/**
 添加时的动画样式

 - FormSheetTransitionStyleNone: 无动画效果
 - FormSheetTransitionStyleSpringCoverVertical: 弹簧动画效果
 */
typedef NS_ENUM(NSUInteger, BTWFormSheetTransitionStyle) {
    BTWFormSheetTransitionStyleNone,
    BTWFormSheetTransitionStyleSpringCoverVertical,
};

/**
 BTWFormSheetNavigationController 移除回调
 */
typedef void(^BTWDidRemoveBlock)(void);

@interface BTWFormSheetNavigationController : UINavigationController

/**
 将 BTWFormSheetNavigationController 添加到 targetVC

 @param targetViewController 目标VC
 @param size BTWFormSheetNavigationController 控制器的 View 的 Size
 @param transitionStyle 添加时动画的样式
 */
- (void)addToTargetViewController:(UIViewController *)targetViewController formSheetNavigationControllerViewSize:(CGSize)size transitionStyle:(BTWFormSheetTransitionStyle)transitionStyle;

/**
 将 BTWFormSheetNavigationController 从 targetVC 移除

 @param targetViewController 目标VC
 @param transitionStyle 移除时的动画样式
 */
- (void)removeFromTargetViewController:(UIViewController *)targetViewController transitionStyle:(BTWFormSheetTransitionStyle)transitionStyle;

@property (nonatomic, strong) BTWDidRemoveBlock didRemoveBlock;

@end
