
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BTWShouldDismissBlock)(void);

@interface BTWFormSheetPresentationController : UIPresentationController

@property (nonatomic, strong) BTWShouldDismissBlock shouldDismissBlock;

@end

NS_ASSUME_NONNULL_END
