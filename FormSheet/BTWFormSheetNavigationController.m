

#import "BTWFormSheetNavigationController.h"

#import "BTWFormSheetMaskView.h"

typedef NS_ENUM(NSUInteger, BTWTransitionDirectionType) {
    BTWTransitionDirectionTypeAdd,
    BTWTransitionDirectionTypeRemove,
};

@interface BTWFormSheetNavigationController ()
{
    BTWFormSheetMaskView *_formSheetMaskView;
    __weak id _keyboardShowObserver;
    __weak id _keyboardHideObserver;
}

@end

@implementation BTWFormSheetNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotificationObserver];
    
    self.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [self removeNotificationObserver];
}

#pragma mark - public

- (void)addToTargetViewController:(UIViewController *)targetViewController formSheetNavigationControllerViewSize:(CGSize)size transitionStyle:(BTWFormSheetTransitionStyle)transitionStyle
{
    BOOL hasContainFormSheet = [targetViewController.childViewControllers containsObject:self];
    
    if ((targetViewController == nil) || CGSizeEqualToSize(size, CGSizeZero) || hasContainFormSheet) {
        return;
    }
    
    _formSheetMaskView = [[BTWFormSheetMaskView alloc] initWithFrame:targetViewController.view.frame];
    _formSheetMaskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    
    UIViewController *windowRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [windowRootVC.view addSubview:_formSheetMaskView];
    
    __weak typeof(self) weakSelf = self;
    _formSheetMaskView.bgClickBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeFromTargetViewController:targetViewController transitionStyle:transitionStyle];
    };
    
    [targetViewController addChildViewController:self];
    self.view.bounds = CGRectMake(0, 0, size.width, size.height);
    
    [self handleAnimationTransitionDirectionType:BTWTransitionDirectionTypeAdd transitionAnimationStyle:transitionStyle targetView:targetViewController.view];
    
    [targetViewController.view addSubview:self.view];
    [self didMoveToParentViewController:targetViewController];
}

- (void)removeFromTargetViewController:(UIViewController *)targetViewController transitionStyle:(BTWFormSheetTransitionStyle)transitionStyle
{
    BOOL hasContainFormSheet = [targetViewController.childViewControllers containsObject:self];
    
    if (hasContainFormSheet == NO) {
        return;
    }
    
    [self willMoveToParentViewController:nil];
    
    [self handleAnimationTransitionDirectionType:BTWTransitionDirectionTypeRemove transitionAnimationStyle:transitionStyle targetView:targetViewController.view];
    
    if (self.didRemoveBlock) {
        self.didRemoveBlock();
    }
    
    BOOL hasContainMaskView = [targetViewController.view.subviews containsObject:_formSheetMaskView];
    
    if (hasContainMaskView) {
        [_formSheetMaskView removeFromSuperview];
    }
}

#pragma mark - transition animation

- (void)handleAnimationTransitionDirectionType:(BTWTransitionDirectionType)transitionDirectionType transitionAnimationStyle:(BTWFormSheetTransitionStyle)formTransitionStyle targetView:(UIView *)targetView
{
    CGFloat targetViewH = CGRectGetHeight(targetView.frame);
    CGFloat targetViewCenterX = CGRectGetMidX(targetView.frame);
    CGFloat targerViewCenterY = CGRectGetMidY(targetView.frame);
    
    if (transitionDirectionType == BTWTransitionDirectionTypeAdd) { // 添加View
        
        if (formTransitionStyle == BTWFormSheetTransitionStyleNone) {
            
            self.view.center = targetView.center;
            
        } else if (formTransitionStyle == BTWFormSheetTransitionStyleSpringCoverVertical) {
            
//            self.view.centerX = targetViewCenterX;
//            self.view.top = targerViewCenterY;
            
            [UIView animateWithDuration:1.5
                                  delay:0.0
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:5
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 
//                                 self.view.centerY = targerViewCenterY;
                                 
                             } completion:^(BOOL finished) {
                             }];
            
        } else {
            // 其他动画效果待补充
        }
        
    } else { // 移除View
        
        if (formTransitionStyle == BTWFormSheetTransitionStyleNone) {
            
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
            
        } else if (formTransitionStyle == BTWFormSheetTransitionStyleSpringCoverVertical) {
            
            [UIView animateWithDuration:1.5
                                  delay:0.0
                 usingSpringWithDamping:0.6
                  initialSpringVelocity:5
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 
//                                 self.view.top = targetViewH;
                                 
                             } completion:^(BOOL finished) {
                                 
                                 [self.view removeFromSuperview];
                                 [self removeFromParentViewController];
                             }];
            
        } else {
            // 其他动画效果待补充
        }
        
    }
    
}

#pragma mark - NSNotificationCenter

- (void)addNotificationObserver
{
    __weak typeof(self) weakSelf = self;
    
    _keyboardShowObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        NSNumber *durationAsNumber = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
        double durationAsDouble = durationAsNumber.doubleValue;
        
        CGFloat y = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        
        [UIView animateWithDuration:durationAsDouble animations:^{
            
//            weakSelf.view.frame = CGRectMake(weakSelf.view.origin.x, y, weakSelf.view.size.width, weakSelf.view.size.height);
        }];
        
    }];
    
    _keyboardHideObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        NSNumber *durationAsNumber = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
        double durationAsDouble = durationAsNumber.doubleValue;
        
        [UIView animateWithDuration:durationAsDouble animations:^{
            
//            weakSelf.view.centerY = _formSheetMaskView.centerY;
        }];
    }];
}

- (void)removeNotificationObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:_keyboardShowObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:_keyboardHideObserver];
}

@end
