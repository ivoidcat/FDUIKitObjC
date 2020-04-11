//
//  FDAlertView.m
//  FDUIKitObjC
//
//  Created by fandongtongxue on 2020/2/27.
//

#import "FDAlertView.h"
#import "FDAction.h"
#import "FDUIDefine.h"
#import "FDUIColorDefine.h"
#import "UIView+FD.h"
#import <YYKit/YYKit.h>
#import <FDFoundationObjC/FDFoundationObjC.h>

@interface FDAlertView ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) UIView *bottomLineView;
@property(nonatomic, assign) CGFloat bottomY;
@property(nonatomic, strong) NSMutableArray *actionArray;

@end

@implementation FDAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message{
    if (self = [super initWithFrame:CGRectMake(40, FD_ScreenHeight, FD_ScreenWidth - 80, 1)]) {
        self.backgroundColor = FD_WhiteColor;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.titleLabel.text = title;
        [self.contentLabel setText:message];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        self.contentLabel.frame = CGRectMake(10, _titleLabel.fd_bottom, self.fd_width - 20, [message fd_textSizeIn:CGSizeMake(self.fd_width - 20, MAXFLOAT) font:[UIFont systemFontOfSize:14]].height + 20);
        self.bottomY = self.contentLabel.fd_bottom + 20;
    }
    return self;
}

- (void)addAction:(FDAction *)action{
    [self.actionArray addObject:action];
}

- (void)onClick:(UIButton *)sender{
    NSLog(@"FDAlertView:点击了%@",sender.titleLabel.text);
    FDAction *action = self.actionArray[sender.tag -100];
    if (action.fd_handleAction) {
        action.fd_handleAction();
    }
    [self hide];
}

- (void)show:(UIView *)superView{
    for (NSInteger i = 0; i < self.actionArray.count; i++) {
        CGFloat buttonWidth = (self.width - 30 ) / self.actionArray.count;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10 + (buttonWidth + 10) * i, self.bottomY, buttonWidth, 35)];
        FDAction *action = self.actionArray[i];
        [button setTitle:action.title forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = button.bounds;
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        if (action.type == FDActionTypeDefault) {
            gl.colors = @[(__bridge id)[UIColor colorWithRed:38/255.0 green:232/255.0 blue:198/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:205/255.0 blue:213/255.0 alpha:1.0].CGColor];
        }else{
            gl.colors = @[(__bridge id)[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1.0].CGColor];
        }
        gl.locations = @[@(0.0),@(1.0f)];
        [button.layer addSublayer:gl];
        
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [self addSubview:button];
        
    }
    
    self.bounds = CGRectMake(0, 0, self.fd_width, self.bottomY + 55);
    [super show:superView type:FDPopTypeCenter];
}

- (NSMutableArray *)actionArray{
    if (!_actionArray) {
        _actionArray = [NSMutableArray array];
    }
    return _actionArray;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, self.fd_width - 20, 25)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _titleLabel.fd_bottom + 20, self.fd_width - 20, 20)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _contentLabel;
}

@end
