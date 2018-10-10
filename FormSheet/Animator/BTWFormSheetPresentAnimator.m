
#import "BTWFormSheetPresentAnimator.h"

@implementation BTWFormSheetPresentAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    CGFloat toViewW = self.vcSize.width;
    CGFloat toViewH = self.vcSize.height;
    
    CGFloat containerW = CGRectGetWidth(containerView.frame);
    CGFloat containerH = CGRectGetHeight(containerView.frame);
    
    CGFloat toViewX = (containerW - toViewW) / 2;
    CGFloat toViewStartY = containerH;
    CGFloat toViewEndY = (containerH - toViewH) / 2;

    CGRect toViewStartFrame = CGRectMake(toViewX, toViewStartY, toViewW, toViewH);
    CGRect toViewFinalFrame = CGRectMake(toViewX, toViewEndY, toViewW, toViewH);
    
    toView.frame = toViewStartFrame;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toView.frame = toViewFinalFrame;
        
    } completion:^(BOOL finished) {
        
        BOOL success = ![transitionContext transitionWasCancelled];
        
        if (success == NO) {
            [toView removeFromSuperview];
        }
        
        [transitionContext completeTransition:success];
    }];
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
