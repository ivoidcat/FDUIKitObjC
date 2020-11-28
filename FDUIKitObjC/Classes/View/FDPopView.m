//
//  FDPopView.m
//  FDUIKitObjC
//
//  Created by fandongtongxue on 2020/2/26.
//

#import "FDPopView.h"
#import "FDUIColorDefine.h"
#import "FDUIDefine.h"
#import "UIView+FD.h"

@interface FDPopView ()

@property(nonatomic, strong) UIView *shadowView;

@end

@implementation FDPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = FD_WhiteColor;
        self.fd_y = FD_ScreenHeight;
    }
    return self;
}

- (void)show:(UIView *)superView type:(FDPopType)type{
    [superView addSubview:self.shadowView];
    [superView addSubview:self];
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        CGFloat offsetY = 0;
        switch (type) {
            case FDPopTypeBottom:
                offsetY = superView.fd_height - strongSelf.fd_height;
                break;
            case FDPopTypeCenter:
                offsetY = ( superView.fd_height - strongSelf.fd_height ) / 2;
                break;
            default:
                break;
        }
        strongSelf.frame = CGRectMake(strongSelf.fd_left, offsetY, strongSelf.fd_width, strongSelf.fd_height);
    }];
}

- (void)hide{
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.frame = CGRectMake(strongSelf.fd_left, self.superview.fd_height, strongSelf.fd_width, strongSelf.fd_height);
    } completion:^(BOOL finished) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.shadowView removeFromSuperview];
        [strongSelf removeFromSuperview];
    }];
}

- (UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FD_ScreenWidth, FD_ScreenHeight)];
        _shadowView.backgroundColor = [FD_BlackColor colorWithAlphaComponent:0.4];
        _shadowView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [_shadowView addGestureRecognizer:tap];
    }
    return _shadowView;
}

@end
