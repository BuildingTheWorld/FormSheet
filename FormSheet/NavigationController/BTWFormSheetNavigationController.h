
#import <UIKit/UIKit.h>

typedef void(^BTWDidDismissNavigationBlock)(void);

@interface BTWFormSheetNavigationController : UINavigationController

- (void)showFormSheetNavigationControllerFromTargetViewController:(UIViewController *)targetViewController formSheetNavigationControllerViewSize:(CGSize)formSheetViewSize;

- (void)disappearFormSheetNavigationController;

@property (nonatomic, strong) BTWDidDismissNavigationBlock didDismissNavigationBlock;

@end
