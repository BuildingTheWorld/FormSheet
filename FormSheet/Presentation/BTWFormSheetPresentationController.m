
#import "BTWFormSheetPresentationController.h"

#import "BTWFormSheetMaskView.h"

@interface BTWFormSheetPresentationController ()
{
    BTWFormSheetMaskView *_maskView;
}
@end

@implementation BTWFormSheetPresentationController

#pragma mark - init

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if (self) {
        
        _maskView = [[BTWFormSheetMaskView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithRed:0.03 green:0.04 blue:0.07 alpha:1.0];

        __weak typeof(self) weakSelf = self;

        _maskView.didTapGesBlock = ^{
            
            if (weakSelf.didTapMaskViewBlock) {
                weakSelf.didTapMaskViewBlock();
            }
        };
    }
    return self;
}

#pragma mark - Tracking the Transition’s Start

- (void)presentationTransitionWillBegin
{
    UIView *containerView = [self containerView];
    
    UIViewController *presentedViewController = [self presentedViewController];
    
    _maskView.frame = containerView.bounds;
    _maskView.alpha = 0.0;
    
    [containerView addSubview:_maskView];
    
    if ([presentedViewController transitionCoordinator])
    {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            _maskView.alpha = 0.5;
            
        } completion:nil];
    }
    else
    {
        _maskView.alpha = 0.5;
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (completed == NO) {
        [_maskView removeFromSuperview];
    }
}

#pragma mark - Tracking the Transition’s End

- (void)dismissalTransitionWillBegin
{
    UIViewController *presentedViewController = [self presentedViewController];
    
    if ([presentedViewController transitionCoordinator])
    {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            
            _maskView.alpha = 0.0;
            
        } completion:nil];
    }
    else
    {
        _maskView.alpha = 0.0;
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES) {
        [_maskView removeFromSuperview];
    }
}

@end
