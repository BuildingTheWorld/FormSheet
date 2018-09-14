

#import "BTWFormSheetBaseViewController.h"

#import "BTWFormSheetMaskView.h"

//#import <Masonry.h>

@interface BTWFormSheetBaseViewController ()
{
    BTWFormSheetMaskView *_maskView;
}

@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong, readwrite) BTWFormSheetNavigationBar *formSheetNaviBar;

@property (nonatomic, strong) BTWFormSheetNavigationController *formSheetNaviController;

@end

@implementation BTWFormSheetBaseViewController

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - setup subViews

- (void)setUpSubViews
{
    [self.view addSubview:self.cornerView];
    [self.view addSubview:self.formSheetNaviBar];
    
//    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
//    [self.formSheetNaviBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.offset(375);
//        make.height.offset(kFormSheetNavigationBarHeight);
//        make.left.right.offset(0);
//        make.top.offset(0);
//    }];
}

#pragma mark - childVC navigationController

- (void)navigationControllerAddToTargetViewController:(UIViewController *)targetVC navigationControlleViewSize:(CGSize)naviCViewSize transitionStyle:(BTWFormSheetTransitionStyle)transitionStyle
{
    [self.formSheetNaviController addToTargetViewController:targetVC formSheetNavigationControllerViewSize:naviCViewSize transitionStyle:transitionStyle];
}

- (void)navigationControllerRemoveFromTargetViewController:(UIViewController *)targetVC transitionStyle:(BTWFormSheetTransitionStyle)transitionStyle
{
    [self.formSheetNaviController removeFromTargetViewController:targetVC transitionStyle:transitionStyle];
}

#pragma mark - childVC 无 navigationController

- (void)addToWindowRootViewControllerWithViewSize:(CGSize)viewSize
{
    UIViewController *windowRootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    BOOL hasContainFormSheet = [windowRootVC.childViewControllers containsObject:self];
    
    if ((windowRootVC == nil) || CGSizeEqualToSize(viewSize, CGSizeZero) || hasContainFormSheet) {
        return;
    }
    
    _maskView = [[BTWFormSheetMaskView alloc] initWithFrame:windowRootVC.view.frame];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    
    [windowRootVC.view addSubview:_maskView];
    
    __weak typeof(self) weakSelf = self;
    _maskView.bgClickBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeFromWindowRootViewController];
    };
    
    [windowRootVC addChildViewController:self];
    self.view.bounds = CGRectMake(0, 0, viewSize.width, viewSize.height);
    self.view.center = windowRootVC.view.center;
    [windowRootVC.view addSubview:self.view];
    [self didMoveToParentViewController:windowRootVC];
}

- (void)removeFromWindowRootViewController
{
    UIViewController *windowRootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    BOOL hasContainFormSheet = [windowRootVC.childViewControllers containsObject:self];
    
    if (hasContainFormSheet == NO) {
        return;
    }
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    if (self.vcDidRemoveBlock) {
        self.vcDidRemoveBlock();
    }
    
    BOOL hasContainMaskView = [windowRootVC.view.subviews containsObject:_maskView];
    
    if (hasContainMaskView) {
        [_maskView removeFromSuperview];
    }
}

#pragma mark - lazy

- (UIView *)cornerView {
    if (_cornerView == nil) {
        _cornerView = [[UIView alloc] init];
        _cornerView.layer.cornerRadius = 10;
        _cornerView.backgroundColor = [UIColor whiteColor];
    }
    return _cornerView;
}

- (BTWFormSheetNavigationBar *)formSheetNaviBar {
    if (_formSheetNaviBar == nil) {
        _formSheetNaviBar = [[BTWFormSheetNavigationBar alloc] init];
        
        __weak typeof(self) weakSelf = self;
        
        _formSheetNaviBar.naviBackClickBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _formSheetNaviBar;
}

- (BTWFormSheetNavigationController *)formSheetNaviController {
    if (_formSheetNaviController == nil) {
        _formSheetNaviController = [[BTWFormSheetNavigationController alloc] initWithRootViewController:self];
        
        __weak typeof(self) weakSelf = self;
        
        _formSheetNaviController.didRemoveBlock = ^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if (strongSelf.naviCDidRemoveBlock) {
                strongSelf.naviCDidRemoveBlock();
            }
            strongSelf.formSheetNaviController = nil;
        };
    }
    return _formSheetNaviController;
}

@end
