//
//  JCActionPanel.m
//  JCActionPanel
//
//  Created by jimple on 14/11/18.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCActionPanel.h"

@interface JCActionPanel ()
<
    UIGestureRecognizerDelegate
>

@property (nonatomic, copy) JCActionPanelClosed closeHandler;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSLayoutConstraint *contentViewBottomConstraint;

@end

@implementation JCActionPanel

+ (JCActionPanel *)createPanelWithContentView:(UIView *)contentView
                                 closeHandler:(JCActionPanelClosed)closeHandler
{
    JCActionPanel *actionPanel = [[JCActionPanel alloc] initWithFrame:[[UIScreen mainScreen] bounds] contentView:contentView closeHander:closeHandler];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:actionPanel];

    return actionPanel;
}

- (void)dismissActionPanel
{
    [UIView animateWithDuration:0.3f animations:^{
        _bgView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
        
        [_contentView setNeedsLayout];
        _contentViewBottomConstraint.constant = _contentView.bounds.size.height;
        [_contentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (_bgView)
        {
            [_bgView removeFromSuperview];
        }else{}
        if (_contentView && (_contentView.superview == self))
        {
            [_contentView removeFromSuperview];
        }else{}
        if (self.superview)
        {
            [self removeFromSuperview];
        }else{}
        
        _bgView = nil;
        _contentView = nil;
        _closeHandler = nil;
        _contentViewBottomConstraint = nil;
    }];
    
}

- (id)initWithFrame:(CGRect)frame contentView:(UIView *)contentView closeHander:(JCActionPanelClosed)closeHandler
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _contentView = contentView;
        _closeHandler = closeHandler;
        
        [self commonInit];
    }
    return self;
}

- (void)dealloc
{
    _contentView = nil;
    _closeHandler = nil;
    _contentViewBottomConstraint = nil;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    [self addSubview:_bgView];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    _tapGesture.delegate = self;
    [_bgView addGestureRecognizer:_tapGesture];
    
    if (_contentView)
    {
        if (_contentView.superview)
        {
            [_contentView removeFromSuperview];
        }else{}
        [self addSubview:_contentView];
        
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
        _contentViewBottomConstraint = [NSLayoutConstraint constraintWithItem:_contentView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.0
                                                                     constant:_contentView.bounds.size.height],
        [self addConstraints:@[
                               _contentViewBottomConstraint,
                               
                                [NSLayoutConstraint constraintWithItem:_contentView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:padding.left],
                                    
                                [NSLayoutConstraint constraintWithItem:_contentView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:-padding.right],
                                    ]];
        [_contentView addConstraint:[NSLayoutConstraint
                                       constraintWithItem:_contentView
                                       attribute:NSLayoutAttributeHeight
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:nil
                                       attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1
                                        constant:_contentView.bounds.size.height]];
        
        [_contentView layoutIfNeeded];
    }else{/* ! Asseert */}

    
    [self performSelector:@selector(animationShow) withObject:nil afterDelay:0.03f];
}

- (void)animationShow
{
    _bgView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    _contentViewBottomConstraint.constant = _contentView.bounds.size.height;
    [UIView animateWithDuration:0.2f animations:^{
        _bgView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        _contentView.alpha = 1.0f;
        
        [_contentView setNeedsLayout];
        _contentViewBottomConstraint.constant = 0.0f;
        [_contentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tapAction:(id)sender
{
    [self dismissActionPanel];
    
    if (self.closeHandler)
    {
        self.closeHandler();
    }
}






















































@end
