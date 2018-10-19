
#import "BTWFormSheetBaseViewController.h"

#import "BTWFormSheetNavigationController.h"
//#import <Masonry.h>

static CGFloat const kFormSheetNavigationBarHeight = 44;

@interface BTWFormSheetBaseViewController ()

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
    [self.view addSubview:self.formSheetNaviBar];
    
//    [self.formSheetNaviBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.offset(375);
//        make.height.offset(kFormSheetNavigationBarHeight);
//        make.left.right.offset(0);
//        make.top.offset(0);
//    }];
}

#pragma mark - public

- (void)showNavigationControllerFromTargetViewController:(UIViewController *)targetViewController navigationControllerViewSize:(CGSize)viewSize
{
    [self.formSheetNaviController showFormSheetNavigationControllerFromTargetViewController:targetViewController formSheetNavigationControllerViewSize:viewSize];
}

- (void)disappearNavigationController
{
    [self.formSheetNaviController disappearFormSheetNavigationController];
}

#pragma mark - lazy

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

        _formSheetNaviController.didDismissNavigationBlock = ^{

            if (weakSelf.disappearNaviCBlock) {
                weakSelf.disappearNaviCBlock();
            }
            
            weakSelf.formSheetNaviController = nil;
            
        };
        
    }
    return _formSheetNaviController;
}

@end
