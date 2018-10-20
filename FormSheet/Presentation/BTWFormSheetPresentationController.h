
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BTWDidTapMaskViewBlock)(void);

@interface BTWFormSheetPresentationController : UIPresentationController

@property (nonatomic, strong) BTWDidTapMaskViewBlock didTapMaskViewBlock;

@end

NS_ASSUME_NONNULL_END
