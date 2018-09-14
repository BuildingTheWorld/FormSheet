

#import "BTWFormSheetMaskView.h"

@interface BTWFormSheetMaskView ()

@end

@implementation BTWFormSheetMaskView

#pragma mark - response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.bgClickBlock) {
        self.bgClickBlock();
    }
}

#pragma mark - public

- (void)addToRootViewControllerView
{
    UIViewController *windowRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [windowRootVC.view addSubview:self];
}

@end
