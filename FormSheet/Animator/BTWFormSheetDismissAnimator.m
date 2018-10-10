
#import "BTWFormSheetDismissAnimator.h"

@interface BTWFormSheetDismissAnimator ()
{
    UIView *_fromView;
}
@end

@implementation BTWFormSheetDismissAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    _fromView = fromView;
    
    CGFloat fromViewW = self.vcSize.width;
    CGFloat fromViewH = self.vcSize.height;
    
    CGFloat containerW = CGRectGetWidth(containerView.frame);
    CGFloat containerH = CGRectGetHeight(containerView.frame);
    
    CGFloat fromViewX = (containerW - fromViewW) / 2;
    CGFloat fromViewY = containerH;
    
    CGRect fromViewFinalFrame = CGRectMake(fromViewX, fromViewY, fromViewW, fromViewH);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromView.frame = fromViewFinalFrame;
        
    } completion:^(BOOL finished) {
        
        BOOL success = ![transitionContext transitionWasCancelled];
        
        [transitionContext completeTransition:success];
    }];
    
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    if (transitionCompleted == YES) {
        [_fromView removeFromSuperview];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

@end
