
#import <UIKit/UIKit.h>

/**
 FormSheetMaskView 点击事件回调
 */
typedef void(^BTWDidTapGesBlock)(void);

@interface BTWFormSheetMaskView : UIView

@property (nonatomic, strong) BTWDidTapGesBlock didTapGesBlock;

@end
