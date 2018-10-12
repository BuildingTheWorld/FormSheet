
#import "BTWFormSheetNavigationController.h"

#import "BTWFormSheetPresentAnimator.h"
#import "BTWFormSheetDismissAnimator.h"
#import "BTWFormSheetPresentationController.h"

@interface BTWFormSheetNavigationController () <UIViewControllerTransitioningDelegate>
{
    __weak id _keyboardShowObserver;
    __weak id _keyboardHideObserver;
    CGSize _formSheetViewSize;
}
@end

@implementation BTWFormSheetNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self addNotificationObserver];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeNotificationObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    
}

#pragma mark - public

- (void)showFormSheetNavigationControllerFromTargetViewController:(UIViewController *)targetViewController formSheetNavigationControllerViewSize:(CGSize)formSheetViewSize
{
    if ((targetViewController == nil) || CGSizeEqualToSize(formSheetViewSize, CGSizeZero)) {
        return;
    }
    
    _formSheetViewSize = formSheetViewSize;
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    [targetViewController presentViewController:self animated:YES completion:nil];
}

- (void)disappearFormSheetNavigationController
{
    __weak typeof(self) weakSelf = self;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.didDismissNavigationBlock) {
            strongSelf.didDismissNavigationBlock();
        }
    }];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    BTWFormSheetPresentAnimator *presentAnimator = [[BTWFormSheetPresentAnimator alloc] init];
    presentAnimator.vcSize = _formSheetViewSize;
    return presentAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    BTWFormSheetDismissAnimator *dismissAnimator = [[BTWFormSheetDismissAnimator alloc] init];
    dismissAnimator.vcSize = _formSheetViewSize;
    return dismissAnimator;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    BTWFormSheetPresentationController *presentationVC = [[BTWFormSheetPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];

    __weak typeof(self) weakSelf = self;
    
    presentationVC.shouldDismissBlock = ^{
        
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if (strongSelf.didDismissNavigationBlock) {
                strongSelf.didDismissNavigationBlock();
            }
        }];
    };

    return presentationVC;
}

#pragma mark - NSNotificationCenter

- (void)addNotificationObserver
{
    __weak typeof(self) weakSelf = self;

    _keyboardShowObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {

        NSNumber *durationAsNumber = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
        double durationAsDouble = durationAsNumber.doubleValue;

        [UIView animateWithDuration:durationAsDouble animations:^{
            
//            weakSelf.view.top = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        }];

    }];

    _keyboardHideObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {

        NSNumber *durationAsNumber = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
        double durationAsDouble = durationAsNumber.doubleValue;

        [UIView animateWithDuration:durationAsDouble animations:^{
            
//            weakSelf.view.centerY = CGRectGetMidY([UIScreen mainScreen].bounds);
        }];
    }];
}

- (void)removeNotificationObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:_keyboardShowObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:_keyboardHideObserver];
}

@end
