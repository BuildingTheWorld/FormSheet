
#import "BTWFormSheetMaskView.h"

@interface BTWFormSheetMaskView ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGes;

@end

@implementation BTWFormSheetMaskView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            [self addGestureRecognizer:self.tapGes];
        });
    }
    return self;
}

#pragma mark - action

- (void)tapGesDidResponder:(UITapGestureRecognizer *)tapGes
{
    if (self.didTapGesBlock) {
        
        [self removeGestureRecognizer:self.tapGes];
        
        self.didTapGesBlock();
    }
}

#pragma mark - lazy

- (UITapGestureRecognizer *)tapGes {
    if (_tapGes == nil) {
        _tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesDidResponder:)];
    }
    return _tapGes;
}

@end
