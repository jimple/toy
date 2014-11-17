//
//  JCAdsorbScrollViewHelper.m
//  JCAdsorbScrollView
//
//  Created by jimple on 14/11/17.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCAdsorbScrollViewHelper.h"


@interface JCAdsorbScrollViewHelper ()

@property (nonatomic, strong) NSArray *xValueArray;
@property (nonatomic, assign) CGFloat cursorXOffset;
@property (nonatomic, assign) BOOL scrlToOriginPoint;
@property (nonatomic, assign) CGFloat lastXOffset;

@end

@implementation JCAdsorbScrollViewHelper

- (instancetype)initWithXValues:(NSArray *)xValueArray cursorXOffset:(CGFloat)cursorXOffset
{
    self = [super init];
    if (self)
    {
        _xValueArray = [NSArray arrayWithArray:xValueArray];
        _cursorXOffset = cursorXOffset;
        
        _scrlToOriginPoint = YES;
        _lastXOffset = 0.0f;
    }else{}
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _scrlToOriginPoint = ((scrollView.contentOffset.x -_lastXOffset) <= 0.0f);
    _lastXOffset = scrollView.contentOffset.x;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastXOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGPoint pt = scrollView.contentOffset;
            pt.x = [self nearbyXValueWithSrcX:scrollView.contentOffset.x + _cursorXOffset] - _cursorXOffset;
            
            [scrollView setContentOffset:pt animated:NO];
        });
    }else{}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGPoint pt = scrollView.contentOffset;
        pt.x = [self nearbyXValueWithSrcX:scrollView.contentOffset.x + _cursorXOffset] - _cursorXOffset;
        
        [scrollView setContentOffset:pt animated:NO];
    });
}

#pragma mark -
- (CGFloat)nearbyXValueWithSrcX:(CGFloat)srcX
{
    CGFloat retX = srcX;
    if (_xValueArray && (_xValueArray.count > 0))
    {
        CGFloat lastX = ((NSNumber *)_xValueArray[(_scrlToOriginPoint ? 0 : (_xValueArray.count-1))]).doubleValue;
        if (_scrlToOriginPoint)
        {
            for (NSNumber *num in _xValueArray)
            {
                CGFloat x = num.doubleValue;
                if (srcX < x)
                {
                    break;
                }else{}
                lastX = x;
            }
        }
        else
        {
            for (long i = (_xValueArray.count - 1); i >= 0; i--)
            {
                CGFloat x = ((NSNumber *)_xValueArray[i]).doubleValue;
                if (srcX >= x)
                {
                    break;
                }else{}
                lastX = x;
            }
        }
        
        retX = lastX;
    }else{}
    return retX;
}


































@end
